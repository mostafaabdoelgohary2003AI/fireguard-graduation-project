import time
import threading
import cv2
import requests

ENDPOINT = "http://localhost:8001/predict"
INTERVAL = 2.0          # seconds between predictions

# Set SOURCE to "webcam", "ip", or "rtsp".
SOURCE = "webcam"
IP_STREAM_URL = "http://192.168.1.100:8080/video"
RTSP_URL = "rtsp://username:password@192.168.1.100:554/stream"

# Retry / reconnect
MAX_FRAME_FAILURES = 5
RECONNECT_DELAY = 5.0
REQUEST_RETRIES = 3
REQUEST_RETRY_DELAY = 1.0

# CPU-saving options
PROCESS_WIDTH = 640     # resize before encoding; 0 = keep original size
JPEG_QUALITY = 80       # 0-100; lower = smaller payload, less CPU on encode


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")


def open_capture():
    if SOURCE == "ip":
        log(f"Connecting to IP stream: {IP_STREAM_URL}")
        return cv2.VideoCapture(IP_STREAM_URL)
    if SOURCE == "rtsp":
        log(f"Connecting to RTSP stream: {RTSP_URL}")
        return cv2.VideoCapture(RTSP_URL, cv2.CAP_FFMPEG)
    log("Opening local webcam...")
    return cv2.VideoCapture(0)


def source_label():
    return {"ip": f"IP stream ({IP_STREAM_URL})",
            "rtsp": f"RTSP stream ({RTSP_URL})"}.get(SOURCE, "webcam")


class FrameReader(threading.Thread):
    """
    Background thread that continuously reads from the capture device.
    Only the latest frame is kept — the buffer is always drained — so
    the main thread never decodes stale queued frames.
    """

    def __init__(self, cap):
        super().__init__(daemon=True)
        self._cap = cap
        self._lock = threading.Lock()
        self._frame = None
        self._ok = True
        self._failures = 0

    def run(self):
        while self._ok:
            ret, frame = self._cap.read()
            with self._lock:
                if ret:
                    self._frame = frame
                    self._failures = 0
                else:
                    self._failures += 1

    def latest(self):
        """Return (frame, consecutive_failure_count)."""
        with self._lock:
            return self._frame, self._failures

    def stop(self):
        self._ok = False


def resize(frame):
    if PROCESS_WIDTH <= 0:
        return frame
    h, w = frame.shape[:2]
    if w <= PROCESS_WIDTH:
        return frame
    scale = PROCESS_WIDTH / w
    return cv2.resize(frame, (PROCESS_WIDTH, int(h * scale)),
                      interpolation=cv2.INTER_AREA)


def send_frame(image_bytes):
    """POST frame to /predict with retries. Returns parsed JSON or None."""
    for attempt in range(1, REQUEST_RETRIES + 1):
        try:
            response = requests.post(
                ENDPOINT,
                files={"file": ("frame.jpg", image_bytes, "image/jpeg")},
                timeout=5,
            )
            if response.status_code == 200:
                return response.json()
            log(f"Server returned {response.status_code} (attempt {attempt}/{REQUEST_RETRIES})")
        except requests.Timeout:
            log(f"Request timed out (attempt {attempt}/{REQUEST_RETRIES})")
        except requests.ConnectionError:
            log(f"Cannot reach {ENDPOINT} (attempt {attempt}/{REQUEST_RETRIES})")
        except requests.RequestException as exc:
            log(f"Request error: {exc} (attempt {attempt}/{REQUEST_RETRIES})")

        if attempt < REQUEST_RETRIES:
            time.sleep(REQUEST_RETRY_DELAY)

    log("All request attempts failed. Will retry on next frame.")
    return None


def main():
    cap = None
    reader = None

    try:
        while True:
            # (Re)open capture and start background reader when needed
            if cap is None or not cap.isOpened():
                if reader is not None:
                    reader.stop()
                if cap is not None:
                    cap.release()

                cap = open_capture()
                if not cap.isOpened():
                    log(f"Could not open {source_label()}. Retrying in {RECONNECT_DELAY}s...")
                    cap = None
                    time.sleep(RECONNECT_DELAY)
                    continue

                reader = FrameReader(cap)
                reader.start()
                log(f"{source_label()} opened. Processing one frame every {INTERVAL}s...")

            # Sleep first — background thread drains the buffer meanwhile
            time.sleep(INTERVAL)

            frame, failures = reader.latest()

            if failures >= MAX_FRAME_FAILURES:
                log(f"Too many consecutive read failures ({failures}). Reconnecting...")
                reader.stop()
                cap.release()
                cap = None
                reader = None
                time.sleep(RECONNECT_DELAY)
                continue

            if frame is None:
                log("No frame available yet. Waiting...")
                continue

            frame = resize(frame)

            success, buffer = cv2.imencode(
                ".jpg", frame, [cv2.IMWRITE_JPEG_QUALITY, JPEG_QUALITY]
            )
            if not success:
                log("Frame encoding failed. Skipping.")
                continue

            data = send_frame(buffer.tobytes())
            if data is not None:
                event_type = data.get("event_type", "none")
                confidence = data.get("confidence", 0.0)
                if event_type != "none" and confidence > 50:
                    log(f"FIRE DETECTED  event_type={event_type}  confidence={confidence}")
                else:
                    log(f"No fire  event_type={event_type}  confidence={confidence}")

    except KeyboardInterrupt:
        log("Stopped by user.")
    finally:
        if reader is not None:
            reader.stop()
        if cap is not None:
            cap.release()


if __name__ == "__main__":
    main()
