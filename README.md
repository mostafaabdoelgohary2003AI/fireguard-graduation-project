# Fire Detection System

A real-time fire and smoke detection system built with a microservices architecture. Detects fire, smoke, and spark events from camera feeds using YOLOv8 AI and notifies through a scalable Django backend.

---

## Project Overview

**FireGuard** is an intelligent fire detection system designed to provide early warning of fire hazards in real-time. The system processes images from cameras or webcams, analyzes them using an AI model trained on fire detection, and triggers notifications through a centralized backend API.

### Key Capabilities
- **Real-time Detection**: Process camera frames at scale with YOLOv8 inference
- **Multiple Event Types**: Detects fire, smoke, and spark events
- **Microservices Architecture**: Independent, scalable AI and backend services
- **Production Ready**: Docker containerization with health checks and orchestration
- **Integrated Notification System**: Events persisted and propagated through Django backend

---

## Architecture

```
Camera / Webcam Client
       │
       ▼
FastAPI AI Service (YOLOv8) ──► Django Backend API ──► Database
       │                             │
       └─────────► /api/events/ ─────┘
```

**Data Flow:**

1. **Camera Input**: Webcam client or external camera source captures frames
2. **AI Analysis**: FastAPI service runs YOLOv8 inference on each frame
3. **Detection Results**: AI service returns event type, confidence score, and bounding boxes
4. **Backend Integration**: If confidence > 50%, event is forwarded to Django via `POST /api/events/`
5. **Persistence**: Django stores event in PostgreSQL and triggers notifications
6. **Notification Layer**: System sends alerts through configured notification channels

---

## Tech Stack

| Component | Technology | Version |
|-----------|-----------|---------|
| AI Service | FastAPI, Ultralytics YOLO | Latest |
| Backend API | Django, Django REST Framework | 3.10+ |
| Database | PostgreSQL | 15 |
| Containerization | Docker, Docker Compose | Latest |
| Camera Client | Python, OpenCV | 4.x |
| ML Framework | PyTorch | via YOLO |

---

## Project Structure

```
fireguard-graduation-project/
├── backend/                           # Django REST API
│   ├── Dockerfile
│   ├── entrypoint.sh                 # DB migration & server startup
│   ├── manage.py
│   ├── requirements.txt
│   ├── accounts/                     # User authentication
│   ├── cameras/                      # Camera management
│   ├── events/                       # Event models & APIs
│   ├── detection/                    # Detection logic
│   ├── notifications/                # Notification system
│   └── fireguard/                    # Django project settings
├── ai_service/                        # FastAPI AI microservice
│   ├── Dockerfile
│   ├── main.py                       # FastAPI server
│   ├── inference.py                  # YOLO inference logic
│   ├── model.py                      # Model loading & management
│   └── requirements.txt
├── flutter_client/                    # Mobile app (under development)
├── webcam_client.py                   # Python webcam demo client
├── demo.py                            # Terminal demo with output
├── docker-compose.yml                 # Service orchestration
└── README.md
```

---

## Key Features

### 🎯 Real-time Fire Detection
- Continuous frame analysis using YOLOv8
- Sub-second inference latency
- Multi-class detection: fire, smoke, spark

### 🏗️ Microservices Architecture
- Decoupled AI and backend services
- Independent scaling capabilities
- Service-to-service communication via REST API

### 🐳 Docker Deployment
- Full containerization with health checks
- Orchestrated startup with dependency management
- Database migrations automated in entrypoint
- Network isolation with custom bridge network

### 🔗 Seamless AI Integration
- AI service exposes `/predict` endpoint
- Backend integrates via `/api/events/`
- Confidence-based filtering (>50% threshold)

### 📊 Event Persistence
- All detections logged to PostgreSQL
- Camera-linked events with timestamps
- Queryable event history and analytics

---

## Setup Instructions

### Prerequisites

- **Docker & Docker Compose** installed ([get Docker](https://docs.docker.com/get-docker/))
- **Python 3.10+** (for local client development)
- **YOLOv8 Model Weights**: Place `best.pt` in `ai_service/` directory
  - Download from your training source or Ultralytics model hub

### 1. Clone Repository

```bash
git clone https://github.com/mostafaabdoelgohary2003AI/fireguard-graduation-project.git
cd fireguard-graduation-project
```

### 2. Prepare AI Model

```bash
# Download YOLOv8 weights (or use your trained model)
# Place the model file as:
# ai_service/best.pt
```

### 3. Configure Environment Variables

Edit `docker-compose.yml` to customize database credentials:

```yaml
environment:
  POSTGRES_DB: firedb           # Database name
  POSTGRES_USER: fireuser       # Database user
  POSTGRES_PASSWORD: firepassword  # Database password
  AI_SERVICE_URL: http://ai_service:8001  # Internal AI service URL
  DB_HOST: db                   # Database hostname
  DB_PORT: 5432                 # Database port
```

---

## Running the System

### Start All Services

```bash
docker-compose up --build
```

**Startup Sequence:**
1. PostgreSQL database starts and waits for healthcheck
2. AI service (FastAPI) initializes YOLO model and starts
3. Backend service waits for DB, runs migrations, then starts Django

**Expected Output:**
```
db_1           | ready to accept connections
ai_service_1   | Uvicorn running on http://0.0.0.0:8001
backend_1      | Starting development server at http://0.0.0.0:8000
```

### Verify Services

| Service | URL | Purpose |
|---------|-----|---------|
| Django API | http://localhost:8000/ | REST API endpoints, admin panel |
| FastAPI AI | http://localhost:8001/ | Inference service, `/predict` endpoint |
| PostgreSQL | localhost:5432 | Database (internal only) |

### Health Checks

Services include automated health checks:

```bash
# Check service status
docker-compose ps

# View logs
docker-compose logs -f backend
docker-compose logs -f ai_service
```

---

## Testing with Webcam Client

### Install Client Dependencies

```bash
pip install opencv-python requests
```

### Run Real-time Webcam Detection

```bash
python webcam_client.py
```

**Output:**
```
Webcam started. Sending frames every 2 seconds...
event_type=none  confidence=0.0
No fire
event_type=fire  confidence=87.34
🔥 FIRE DETECTED
```

### Run Terminal Demo

```bash
python demo.py
```

Displays detection results with bounding box visualization.

---

## API Endpoints

### FastAPI AI Service

#### `POST /predict`

Send an image frame for inference.

**Request:**
```bash
curl -X POST http://localhost:8001/predict \
  -F "file=@frame.jpg"
```

**Response:**
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
    },
    {
      "label": "smoke",
      "confidence": 72.15,
      "x1": 95.0,
      "y1": 50.0,
      "x2": 400.0,
      "y2": 300.0
    }
  ]
}
```

**Response Schema:**

| Field | Type | Description |
|-------|------|-------------|
| `event_type` | string | Event type: `"fire"`, `"smoke"`, `"spark"`, or `"none"` |
| `confidence` | float | Highest confidence score (0–100) |
| `detections` | array | All detected objects with coordinates |

---

### Django Backend API

#### `POST /api/events/`

Log a fire/smoke detection event.

**Request Body:**
```json
{
  "camera": 1,
  "event_type": "fire",
  "ai_confidence": 87.34
}
```

**Response:**
```json
{
  "id": 42,
  "camera": 1,
  "event_type": "fire",
  "ai_confidence": 87.34,
  "timestamp": "2026-04-21T14:32:00Z",
  "resolved": false
}
```

#### `POST /api/predict/`

Proxy endpoint that accepts an image, runs AI inference, and returns results.

**Request:**
```bash
curl -X POST http://localhost:8000/api/predict/ \
  -F "file=@frame.jpg"
```

**Response:** Same as FastAPI `/predict`

#### Additional Endpoints

- `GET /api/events/` — List all detected events
- `GET /api/events/{id}/` — Retrieve specific event
- `GET /api/cameras/` — List registered cameras
- `POST /api/cameras/` — Register new camera

---

## Database Migrations

Migrations run automatically on backend startup via `entrypoint.sh`.

**To manually apply migrations:**

```bash
docker-compose exec backend python manage.py migrate
```

**To create a new migration:**

```bash
docker-compose exec backend python manage.py makemigrations
```

---

## Project Status

### ✅ Completed

- **Django Backend**: Fully functional REST API with user authentication, camera management, event logging, and notification framework
- **FastAPI AI Service**: Production-ready YOLO inference server with health checks
- **Docker Deployment**: Complete containerization with orchestration and health checks
- **Webcam Client**: Working Python client for real-time testing
- **Database Layer**: PostgreSQL setup with migrations and models

### 🔄 Under Development

- **Flutter Mobile Client**: UI/UX design and API integration in progress
  - Located in `flutter_client/` directory
  - Expected features: live camera feed, event notifications, alert history
  - Estimated completion: Post-graduation iteration

---

## Future Work

### 📱 Mobile Application
- Complete Flutter mobile client with push notifications
- Real-time camera streaming to mobile devices
- Event history and analytics dashboard
- User preference settings and alert configuration

### 🧠 Model Improvements
- Expand training dataset with diverse fire scenarios
- Fine-tune YOLOv8 for improved accuracy and low false-positive rate
- Support additional detection classes (e.g., embers, heat haze)
- Implement model versioning and A/B testing

### 🎥 Enhanced Streaming
- WebSocket integration for real-time frame streaming
- Multi-camera support with aggregated event dashboard
- Video archival and playback system
- Cloud storage integration for event footage

### 📊 Analytics & Reporting
- Event statistics and trend analysis
- False positive rate tracking
- Performance metrics dashboard
- Incident reports generation

### 🔐 Security & Compliance
- End-to-end encryption for sensitive data
- GDPR-compliant data retention policies
- Role-based access control (RBAC)
- Audit logging for all system actions

---

## Troubleshooting

### Services fail to start

```bash
# Check logs
docker-compose logs backend
docker-compose logs ai_service

# Ensure DB is healthy
docker-compose ps
```

### AI service model not found

```bash
# Verify model exists
ls -la ai_service/best.pt

# Rebuild image if needed
docker-compose build ai_service
```

### Database connection errors

```bash
# Wait for DB initialization
docker-compose logs db

# Reset database (CAUTION)
docker-compose down -v
docker-compose up --build
```

### Webcam client connection refused

```bash
# Verify services are running
docker-compose ps

# Check AI service is accessible
curl http://localhost:8001/
```

---

## Contributing

Contributions are welcome! Please follow standard Git workflow:

1. Create feature branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -am 'Add feature'`
3. Push to branch: `git push origin feature/your-feature`
4. Submit pull request

---

## License

This project is part of a graduation capstone. All rights reserved.

---

## Contact & Support

For questions or issues, please create a GitHub issue or contact the development team.

**Project Lead**: Mostafa Abdoelgohary  
**Repository**: [fireguard-graduation-project](https://github.com/mostafaabdoelgohary2003AI/fireguard-graduation-project)
```
