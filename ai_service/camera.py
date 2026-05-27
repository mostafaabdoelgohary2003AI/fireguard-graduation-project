import cv2
import requests
import datetime
import time
from ultralytics import YOLO


# Load YOLO model
model = YOLO('best.pt')


# API endpoint
API_URL = "https://bodareda0001.pythonanywhere.com/api/events/"


# Cooldown between alerts
last_sent_time = 0
COOLDOWN_SECONDS = 10


# Camera ID from Django database
CAMERA_ID = 1


# Open webcam
cap = cv2.VideoCapture(0)

if not cap.isOpened():
    print("Error: Could not open camera.")
    exit()

print("Starting fire detection. Press 'q' to quit.")

while True:
    ret, frame = cap.read()

    if not ret:
        print("Failed to read frame.")
        break

    # Run YOLO prediction
    results = model(frame, conf=0.5, stream=True)

    detected = False
    label = None
    confidence = 0
    annotated_frame = frame

    for r in results:

        annotated_frame = r.plot()

        if r.boxes is not None and len(r.boxes) > 0:

            for box in r.boxes:

                cls_id = int(box.cls[0])

                # Convert confidence from 0-1 to 0-100
                confidence = float(box.conf[0]) * 100

                label = r.names[cls_id].lower()

                detected = True
                break

    current_time = time.time()

    # Send alert only after cooldown
    if detected and (current_time - last_sent_time > COOLDOWN_SECONDS):

        print(f"Detected: {label} ({confidence:.2f}%)")

        # Save snapshot locally
        timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")

        image_name = f"alert_{timestamp}.jpg"

        cv2.imwrite(image_name, annotated_frame)

        try:

            with open(image_name, "rb") as img_file:

                files = {
                    "snapshot": img_file
                }

                data = {
                    "camera": CAMERA_ID,
                    "event_type": label,
                    "ai_confidence": confidence,
                    "notes": "Detected automatically by AI system"
                }

                response = requests.post(
                    API_URL,
                    files=files,
                    data=data
                )

                print("Status Code:", response.status_code)
                print("Response:", response.text)

                if response.status_code == 201:

                    print("Alert sent successfully.")

                    last_sent_time = current_time

                else:
                    print("Failed to send alert.")

        except Exception as e:
            print("Error sending request:", e)

    # Show detection window
    cv2.imshow("Fire & Smoke Detection", annotated_frame)

    # Quit on pressing q
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break


cap.release()
cv2.destroyAllWindows()