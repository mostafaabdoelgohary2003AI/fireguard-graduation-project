import time

import cv2
import requests

ENDPOINT = "http://localhost:8001/predict"
INTERVAL = 2.0
SEPARATOR = "-" * 40


def send_frame(frame: cv2.typing.MatLike) -> dict | None:
    _, buffer = cv2.imencode(".jpg", frame)
    try:
        response = requests.post(
            ENDPOINT,
            files={"file": ("frame.jpg", buffer.tobytes(), "image/jpeg")},
            timeout=5,
        )
        return response.json()
    except requests.RequestException as exc:
        print(f"[ERROR] Connection failed: {exc}")
        return None


def print_result(data: dict) -> None:
    event_type = data.get("event_type", "none")
    confidence = data.get("confidence", 0.0)
    detections = data.get("detections", [])

    print(SEPARATOR)
    print(f"  Event     : {event_type.upper()}")
    print(f"  Confidence: {confidence}%")

    if detections:
        print(f"  Detections: {len(detections)}")
        for d in detections:
            print(f"    - {d['label']} {d['confidence']}%  [{d['x1']},{d['y1']} → {d['x2']},{d['y2']}]")

    if event_type != "none":
        print()
        print("  *** ALERT: FIRE DETECTED ***")

    print(SEPARATOR)


def main():
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("[ERROR] Could not open webcam.")
        return

    print("Demo running. Press Ctrl+C to stop.\n")

    try:
        while True:
            ret, frame = cap.read()
            if not ret:
                print("[WARNING] Failed to capture frame.")
                time.sleep(INTERVAL)
                continue

            data = send_frame(frame)
            if data:
                print_result(data)

            time.sleep(INTERVAL)

    except KeyboardInterrupt:
        print("\nStopped.")
    finally:
        cap.release()


if __name__ == "__main__":
    main()
