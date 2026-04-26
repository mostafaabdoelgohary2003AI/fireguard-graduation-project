# FireGuard — Real-Time Fire & Smoke Detection System

A graduation project built with a microservices architecture. Detects fire and smoke from camera feeds using YOLOv8 and notifies users via a Django REST backend and Flutter mobile app.

---

## Architecture

```
Camera / Webcam Client
        │
        ▼
FastAPI AI Service (YOLOv8)   ──POST /api/events/──►   Django Backend (DRF)
   port 8001                                                 port 8000
        │                                                       │
        └──────────── Returns detection result ◄───────         ▼
                                                         SQLite Database
                                                               │
                                                               ▼
                                                       Flutter Mobile App
                                                     (FCM push notifications)
```

**Flow:**
1. A camera client POSTs a frame to `POST /predict?camera_id=<id>`
2. AI service runs YOLOv8 inference; if confidence > 50%, notifies the backend
3. Backend persists the event and sends FCM push notifications to registered devices

---

## Tech Stack

| Component       | Technology                        |
|-----------------|-----------------------------------|
| AI Service      | FastAPI, Ultralytics YOLOv8, OpenCV |
| Backend API     | Django 4.x, Django REST Framework |
| Database        | SQLite (local / development)      |
| Notifications   | Firebase Cloud Messaging (FCM)    |
| Containerization| Docker, Docker Compose            |
| Mobile Client   | Flutter (in development)          |

> **Database:** SQLite is used intentionally for simplicity during development. No PostgreSQL setup is required.

---

## Project Structure

```
Fire Detection/
├── ai_service/
│   ├── Dockerfile
│   ├── main.py            # FastAPI app + /predict endpoint
│   ├── inference.py       # FireDetector class, backend notification
│   ├── model.py           # YOLO model loading & inference pipeline
│   ├── requirements.txt
│   └── model/
│       └── best.pt        # YOLOv8 weights (not committed)
├── backend/
│   ├── Dockerfile
│   ├── entrypoint.sh      # Runs migrations then starts server
│   ├── manage.py
│   ├── requirements.txt
│   ├── fireguard/         # Django project settings & URLs
│   ├── accounts/          # Auth: register, login, profile
│   ├── cameras/           # Camera & zone management
│   ├── events/            # Fire event models & API
│   └── notifications/     # FCM device tokens & push alerts
├── flutter_client/
│   └── fire_detection_client.dart
├── webcam_client.py       # Python demo: sends webcam frames to AI service
├── demo.py                # Terminal demo with bounding box output
├── docker-compose.yml
└── README.md
```

---

## Prerequisites

- Docker & Docker Compose
- YOLOv8 model weights — place as `ai_service/model/best.pt`
- Firebase service account JSON — place as `backend/firebase_credentials.json` (never commit this file)

---

## Run the Project

### Option A — Docker (recommended)

```bash
docker compose up --build
```

| Service      | URL                        |
|--------------|----------------------------|
| Django API   | http://localhost:8000      |
| FastAPI AI   | http://localhost:8001      |

> On first run, `entrypoint.sh` automatically applies Django migrations.

To stop:
```bash
docker compose down
```

---

### Option B — Manual (no Docker)

**1. AI Service**

```bash
cd ai_service
pip install -r requirements.txt
uvicorn main:app --host 0.0.0.0 --port 8001 --reload
```

Set backend URL if different from default:
```bash
export DJANGO_BACKEND_URL=http://localhost:8000
```

**2. Backend**

```bash
cd backend
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
```

---

## API Reference

### AI Service — `POST /predict`

Send a camera frame for inference.

```bash
curl -X POST "http://localhost:8001/predict?camera_id=1" \
  -F "file=@frame.jpg"
```

| Query Param | Type | Default | Description                      |
|-------------|------|---------|----------------------------------|
| `camera_id` | int  | `1`     | Database ID of the source camera |

**Response:**
```json
{
  "event_type": "fire",
  "confidence": 87.34,
  "detections": [
    {
      "label": "fire",
      "confidence": 87.34,
      "x1": 120.5, "y1": 80.2,
      "x2": 340.1, "y2": 260.9
    }
  ]
}
```

`event_type` is `"fire"`, `"smoke"`, or `"none"`. Confidence is 0–100.

---

### Backend — Key Endpoints

All endpoints except `POST /api/events/` and auth routes require `Authorization: Token <token>`.

| Method | Endpoint                        | Description                    |
|--------|---------------------------------|--------------------------------|
| POST   | `/api/auth/register/`           | Register a new user            |
| POST   | `/api/auth/login/`              | Login, returns auth token      |
| GET    | `/api/events/`                  | List fire events (filterable)  |
| POST   | `/api/events/`                  | Create event (used by AI service) |
| GET    | `/api/events/active/`           | Latest active event            |
| GET    | `/api/events/stats/`            | Event count statistics         |
| PATCH  | `/api/events/<id>/resolve/`     | Mark event as resolved         |
| PATCH  | `/api/events/<id>/false-alarm/` | Mark as false alarm            |
| GET    | `/api/cameras/`                 | List cameras                   |
| GET    | `/api/notifications/`           | List notification preferences  |

**Filter events:**
```
GET /api/events/?status=active&type=fire&camera=1&zone=2
```

---

## Webcam Demo Client

```bash
pip install opencv-python requests
python webcam_client.py
```

Sends a frame every 2 seconds to `http://localhost:8001/predict`.

---

## Flutter Client

The `flutter_client/fire_detection_client.dart` targets the AI service. Set the server URL at build time:

```bash
flutter run --dart-define=AI_SERVICE_URL=http://192.168.1.100:8001
```

Default (Android emulator): `http://10.0.2.2:8001`

---

## Environment Variables

| Variable              | Service    | Default                   | Description                          |
|-----------------------|------------|---------------------------|--------------------------------------|
| `DJANGO_BACKEND_URL`  | AI Service | `http://backend:8000`     | Backend URL for event notifications  |
| `SECRET_KEY`          | Backend    | *(fallback set)*          | Django secret key — set in prod      |
| `DEBUG`               | Backend    | `True`                    | Set to `False` in production         |
| `FIREBASE_CREDENTIALS_PATH` | Backend | `firebase_credentials.json` | Path to FCM service account      |

---

## Troubleshooting

**AI service fails to start — model not found**
```bash
# Ensure weights exist at:
ls ai_service/model/best.pt
```

**Backend fails — missing migrations**
```bash
docker compose exec backend python manage.py migrate
```

**FCM notifications not sending**
- Confirm `backend/firebase_credentials.json` exists and is valid
- Check `docker compose logs backend` for Firebase initialization errors

---

## License

Graduation capstone project. All rights reserved.

**Author:** Mostafa Abdoelgohary
