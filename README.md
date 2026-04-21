# Fire Detection AI System

A real-time fire and smoke detection system built as a microservice architecture. Images from cameras or clients are analyzed by a YOLO-based AI service, and detected events are forwarded to a Django backend for storage and notification handling.

---

## Architecture

```
Camera / Client
      │
      ▼
FastAPI AI Service  ──►  Django Backend  ──►  Notifications
   (YOLO model)          (REST API)
      │                       │
      │                  PostgreSQL DB
      ▼
  /api/events/
```

1. A camera client or upstream system sends an image to the FastAPI AI service.
2. FastAPI runs YOLO inference and returns detected event type, confidence, and bounding boxes.
3. If confidence exceeds the threshold, FastAPI forwards the event to Django via `POST /api/events/`.
4. Django persists the event and handles downstream notifications.

---

## Tech Stack

| Component     | Technology                  |
|---------------|-----------------------------|
| AI Service    | FastAPI, Ultralytics YOLO   |
| Backend API   | Django, Django REST Framework |
| Database      | PostgreSQL 15               |
| Containerization | Docker, docker-compose   |
| Camera Client | Python, OpenCV              |

---

## Project Structure

```
.
├── backend/                  # Django REST API
│   ├── Dockerfile
│   ├── entrypoint.sh
│   ├── manage.py
│   └── requirements.txt
├── ai_service/               # FastAPI AI microservice
│   ├── Dockerfile
│   ├── main.py
│   ├── inference.py
│   ├── model.py
│   └── requirements.txt
├── webcam_client.py          # Webcam demo client
├── demo.py                   # Terminal demo with detection output
└── docker-compose.yml
```

---

## Setup

### Prerequisites

- [Docker](https://www.docker.com/) and Docker Compose installed
- YOLO model weights file at `ai_service/model/best.pt`

### Clone the repository

```bash
git clone https://github.com/your-org/fire-detection.git
cd fire-detection
```

### Configure environment

Environment variables are defined directly in `docker-compose.yml`. Update them if needed:

| Variable         | Default         | Description              |
|------------------|-----------------|--------------------------|
| `DB_NAME`        | `firedb`        | PostgreSQL database name |
| `DB_USER`        | `fireuser`      | PostgreSQL user          |
| `DB_PASSWORD`    | `firepassword`  | PostgreSQL password      |
| `AI_SERVICE_URL` | `http://ai_service:8001` | Internal AI service URL |

---

## Running the System

### Start all services

```bash
docker-compose up --build
```

Services start in dependency order:
1. `db` (PostgreSQL) — must pass healthcheck first
2. `ai_service` (FastAPI) — must pass healthcheck first
3. `backend` (Django) — runs migrations then starts server

### Verify services are running

| Service     | URL                          |
|-------------|------------------------------|
| Django API  | http://localhost:8000/       |
| FastAPI AI  | http://localhost:8001/       |

### Run the webcam client

```bash
pip install opencv-python requests
python webcam_client.py
```

### Run the terminal demo

```bash
python demo.py
```

---

## API Endpoints

### FastAPI AI Service

#### `POST /predict`

Accepts an image file and returns detection results.

**Request**

```bash
curl -X POST http://localhost:8001/predict \
  -F "file=@frame.jpg"
```

**Response**

```json
{
  "event_type": "fire",
  "confidence": 87.34,
  "detections": [
    {
      "label": "fire",
      "confidence": 87.34,
      "x1": 120.5,
      "y1": 80.2,
      "x2": 340.1,
      "y2": 260.9
    }
  ]
}
```

| Field        | Type    | Description                              |
|--------------|---------|------------------------------------------|
| `event_type` | string  | `"fire"`, `"smoke"`, `"spark"`, or `"none"` |
| `confidence` | float   | Confidence percentage (0–100)            |
| `detections` | array   | All detected objects with bounding boxes |

---

### Django Backend

#### `POST /api/events/`

Receives fire/smoke events from the AI service.

**Request body**

```json
{
  "camera": 1,
  "event_type": "fire",
  "ai_confidence": 87.34
}
```

#### `POST /api/predict/`

Proxy endpoint — accepts an image upload, forwards it to the AI service, and returns the result.

```bash
curl -X POST http://localhost:8000/api/predict/ \
  -F "file=@frame.jpg"
```

---

## Notes

- The AI service runs as an independent microservice and can be scaled or replaced without modifying the Django backend.
- Docker healthchecks ensure PostgreSQL and the AI service are ready before Django starts.
- The `entrypoint.sh` script in the backend container waits for the database, runs `migrate`, then starts the server.
- Only detections with confidence above 50% trigger a notification to Django.
- The YOLO model targets three classes: `fire`, `smoke`, and `spark`.
