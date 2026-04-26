import time
import cv2
import requests

ENDPOINT = "http://localhost:8001/predict"
INTERVAL = 2.0


def main():
    cap = cv2.VideoCapture(0)
    if not cap.isOpened():
        print("Error: could not open webcam.")
        return

    print("Webcam started. Sending frames every 2 seconds...")

    try:
        while True:
            ret, frame = cap.read()
            if not ret:
                print("Warning: failed to capture frame.")
                time.sleep(INTERVAL)
                continue

            success, buffer = cv2.imencode(".jpg", frame)
            if not success:
                print("Encoding failed")
                continue

            image_bytes = buffer.tobytes()

            try:
                response = requests.post(
                    ENDPOINT,
                    files={"file": ("frame.jpg", image_bytes, "image/jpeg")},
                    timeout=5,
                )

                if response.status_code != 200:
                    print(f"Server error: {response.status_code}")
                    continue

                data = response.json()
                event_type = data.get("event_type", "none")
                confidence = data.get("confidence", 0.0)

                print(f"event_type={event_type}  confidence={confidence}")

                if event_type != "none" and confidence > 50:
                    print("🔥 FIRE DETECTED")
                else:
                    print("No fire")

            except requests.RequestException as exc:
                print(f"Connection error: {exc}")

            time.sleep(INTERVAL)

    except KeyboardInterrupt:
        print("Stopped.")
    finally:
        cap.release()


if __name__ == "__main__":
    main()