# 🔥 FireGuard - Real-Time Fire Detection System

[![Python](https://img.shields.io/badge/Python-96.1%25-3776ab?logo=python&logoColor=white)](https://www.python.org/)
[![Dart/Flutter](https://img.shields.io/badge/Dart-2.5%25-0175C2?logo=dart&logoColor=white)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-Proprietary-red)](#license)

An intelligent, production-ready fire detection system using YOLOv8 deep learning with a microservices architecture. Detects fire, smoke, and spark events from camera feeds in real-time and provides scalable notifications through Django REST API.

## 🎯 Project Overview

**FireGuard** is designed for early warning detection of fire hazards in real-time across multiple camera feeds. The system processes video streams using state-of-the-art YOLO computer vision, maintains event logs in PostgreSQL, and integrates seamlessly with mobile and web clients through REST APIs.

### ✨ Key Capabilities

- **Real-time Detection**: YOLOv8 inference with sub-second latency on camera frames
- **Multi-class Detection**: Identifies fire, smoke, and spark events
- **Microservices Architecture**: Independent AI and backend services for horizontal scaling
- **Production-Ready Deployment**: Full Docker containerization with health checks
- **Event Persistence**: All detections logged to PostgreSQL with queryable history
- **Firebase Integration**: Push notifications via Firebase Cloud Messaging
- **Mobile Support**: Flutter client with camera integration and real-time alerts

---

## 🏗️ Architecture Overview

```
┌─────────────────────┐
│   Camera / Webcam   │
│   (Real-time Video) │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────────────────────────────────────────────┐
│      FastAPI AI Service (Port 8001)                         │
│  • YOLOv8 Model Inference                                   │
│  • Image Processing (OpenCV)                                │
│  • Confidence Filtering (>50% threshold)                    │
│  • Backend Event Notification                               │
└──────────┬──────────────────────────────────────────────────┘
           │ (POST /api/events/)
           ▼
┌─────────────────────────────────────────────────────────────┐
│      Django REST API Backend (Port 8000)                    │
│  • User Authentication                                       │
│  • Camera Management                                         │
│  • Event Logging & Queries                                  │
│  • Notification Dispatch (Firebase)                         │
│  • Database Migrations                                       │
└──────────┬──────────────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────────────┐
│      PostgreSQL Database (Port 5432)                        │
│  • Events Table (timestamps, confidence, type)              │
│  • Cameras Table (metadata, locations)                      │
│  • User Accounts & Permissions                              │
│  • Notification History                                     │
└─────────────────────────────────────────────────────────────┘

┌──────────────────────────┐
│   Flutter Mobile Client  │
│  • Live Camera Feed      │
│  • Fire Alerts           │
│  • Event History         │
└──────────────────────────┘

┌──────────────────────────┐
│  Python Webcam Client    │
│  • Real-time Testing     │
│  • Local Development     │
└──────────────────────────┘
```

### Data Flow

1. **Capture**: Camera/webcam captures frames continuously
2. **Inference**: FastAPI AI service runs YOLOv8 predictions on each frame
3. **Filter**: Events with confidence > 50% are forwarded to backend
4. **Log**: Django API stores event in PostgreSQL with camera metadata
5. **Notify**: Firebase Cloud Messaging sends push notifications to users
6. **History**: Events queryable via REST API endpoints

---

## 📁 Project Structure

```
fireguard-graduation-project/
├── backend/                              # Django REST API Service
│   ├── Dockerfile                       # Django container image
│   ├── entrypoint.sh                    # Database setup & startup script
│   ├── manage.py                        # Django CLI tool
│   ├── requirements.txt                 # Python dependencies
│   ├── firebase_credentials.json        # Firebase service account
│   │
│   ├── accounts/                        # User authentication & profiles
│   │   ├── __init__.py
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── serializers.py
│   │   └── urls.py
│   │
│   ├── cameras/                         # Camera management
│   │   ├── __init__.py
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── serializers.py
│   │   └── urls.py
│   │
│   ├── events/                          # Event logging & queries
│   │   ├── __init__.py
│   │   ├── models.py                    # Event model with timestamps
│   │   ├── views.py                     # List, create, retrieve events
│   │   ├── serializers.py
│   │   └── urls.py
│   │
│   ├── notifications/                   # Firebase notification system
│   │   ├── __init__.py
│   │   ├── firebase_handler.py         # Firebase Cloud Messaging
│   │   ├── models.py                    # Notification logs
│   │   └── views.py
│   │
│   └── fireguard/                       # Django project settings
│       ├── __init__.py
│       ├── settings.py                  # Database, middleware, apps config
│       ├── urls.py                      # Main URL routing
│       ├── wsgi.py
│       └── asgi.py
│
├── ai_service/                          # FastAPI AI Microservice
│   ├── Dockerfile                       # FastAPI container image
│   ├── requirements.txt                 # Python dependencies
│   │
│   ├── main.py                          # FastAPI server
│   │   ├── POST /predict                # Inference endpoint
│   │   ├── GET /status                  # Service health
│   │   └── GET /cameras                 # Mock camera list
│   │
│   ├── inference.py                     # YOLOv8 inference pipeline
│   │   ├── FireDetector class           # Main detection logic
│   │   ├── predict()                    # Process image & return results
│   │   └── notify_backend()             # Send events to Django
│   │
│   └── model.py                         # YOLO model management
│       ├── load_model()                 # Load best.pt weights
│       ├── run_inference()              # YOLOv8 forward pass
│       └── Model caching                # In-memory model persistence
│
├── flutter_client/                      # Flutter Mobile Application
│   └── fire_detection_client.dart      # Main client code
│       ├── captureAndPredict()          # Image capture & inference
│       ├── Camera integration           # Native device camera
│       └── Error handling               # Connection errors
│
├── docker-compose.yml                   # Service orchestration
├── webcam_client.py                     # Python webcam testing client
├── demo.py                              # Terminal demo script
└── README.md                            # This file
```

---

## 🛠️ Tech Stack

| Component | Technology | Version | Purpose |
|-----------|-----------|---------|---------|
| **AI Inference** | YOLOv8 (Ultralytics) | 8.2.0+ | Real-time object detection |
| **AI Server** | FastAPI | 0.110.0+ | High-performance async API |
| **Image Processing** | OpenCV | 4.9.0+ | Frame decoding & preprocessing |
| **Backend API** | Django | 4.2-4.9 | REST API & ORM |
| **REST Framework** | DRF | 3.15.0+ | API serialization & routing |
| **Database** | PostgreSQL | 15 | Event persistence & queries |
| **Notifications** | Firebase | 6.5.0+ | Push notifications |
| **Container Runtime** | Docker | Latest | Service containerization |
| **Orchestration** | Docker Compose | Latest | Multi-service deployment |
| **Mobile** | Flutter | Latest | Cross-platform mobile client |
| **Mobile Backend** | Dart | Latest | Client-side networking |
| **Web Server** | Uvicorn | 0.29.0+ | ASGI server for FastAPI |
| **CORS** | django-cors-headers | 4.3.0+ | Cross-origin requests |
| **Image Library** | Pillow | 10.3.0+ | Image manipulation |
| **HTTP Client** | Requests | 2.31.0+ | HTTP requests (Python) |

---

## 🚀 Quick Start

### Prerequisites

- **Docker & Docker Compose**: [Installation Guide](https://docs.docker.com/get-docker/)
- **Python 3.10+** (for local client development)
- **YOLOv8 Model Weights**: Download `best.pt` trained model file
- **Firebase Credentials** (optional): For push notifications

### 1. Clone the Repository

```bash
git clone https://github.com/mostafaabdoelgohary2003AI/fireguard-graduation-project.git
cd fireguard-graduation-project
```

### 2. Prepare AI Model

```bash
# Place your trained YOLOv8 model in ai_service/
# The model should be named: best.pt
# Download format: Ultralytics YOLOv8 .pt weights

ls -la ai_service/best.pt  # Verify file exists
```

### 3. Environment Configuration (Optional)

Edit `docker-compose.yml` to customize settings:

```yaml
environment:
  POSTGRES_DB: firedb              # Database name
  POSTGRES_USER: fireuser          # Database user
  POSTGRES_PASSWORD: firepassword  # Database password (change in production!)
  AI_SERVICE_URL: http://ai_service:8001  # Internal AI service URL
  DB_HOST: db                      # Database hostname
  DB_PORT: 5432                    # Database port
```

### 4. Start All Services

```bash
docker-compose up --build
```

**Expected Output:**
```
db_1           | LOG:  database system is ready to accept connections
ai_service_1   | INFO:     Uvicorn running on http://0.0.0.0:8001
backend_1      | Starting development server at http://0.0.0.0:8000
```

### 5. Verify Deployment

| Service | URL | Status |
|---------|-----|--------|
| Django API | http://localhost:8000/ | Admin panel, REST endpoints |
| FastAPI AI | http://localhost:8001/ | Prediction service, health check |
| PostgreSQL | localhost:5432 | Database (internal only) |

---

## 📖 API Endpoints

### FastAPI AI Service (`/ai_service`)

#### **GET** `/` - Health Check
Returns service status.

```bash
curl http://localhost:8001/
```

**Response:**
```json
{
  "message": "ok"
}
```

---

#### **POST** `/predict` - Fire Detection Inference

Send an image frame for YOLOv8 inference.

**Request:**
```bash
curl -X POST http://localhost:8001/predict \
  -F "file=@frame.jpg" \
  -F "camera_id=1"
```

**Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `file` | File | ✓ | Image file (JPEG/PNG) |
| `camera_id` | Integer | Optional | Camera identifier (default: 1) |

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
| `event_type` | string | `"fire"`, `"smoke"`, `"spark"`, or `"none"` |
| `confidence` | float | Highest confidence score (0–100) |
| `detections` | array | Array of detected objects with bounding boxes |
| `detections[].label` | string | Detection class name |
| `detections[].confidence` | float | Detection confidence (0–100) |
| `detections[].x1, y1, x2, y2` | float | Bounding box pixel coordinates |

---

#### **GET** `/status` - System Status
Returns camera system status information.

```bash
curl http://localhost:8001/status
```

**Response:**
```json
{
  "total_cameras": 12,
  "online": 11
}
```

---

#### **GET** `/cameras` - Camera List
Returns list of active cameras.

```bash
curl http://localhost:8001/cameras
```

**Response:**
```json
[
  {
    "name": "Main Entrance",
    "status": "live"
  },
  {
    "name": "Warehouse B",
    "status": "live"
  }
]
```

---

### Django REST API (`/backend`)

#### **POST** `/api/events/` - Log Detection Event

Record a fire/smoke detection event to database.

**Request:**
```bash
curl -X POST http://localhost:8000/api/events/ \
  -H "Content-Type: application/json" \
  -d '{
    "camera": 1,
    "event_type": "fire",
    "ai_confidence": 87.34
  }'
```

**Request Body:**
| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `camera` | Integer | ✓ | Camera ID |
| `event_type` | String | ✓ | `"fire"`, `"smoke"`, or `"spark"` |
| `ai_confidence` | Float | ✓ | Confidence score (0–100) |

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

---

#### **GET** `/api/events/` - List All Events

Query detection events with filtering and pagination.

**Request:**
```bash
curl http://localhost:8000/api/events/?event_type=fire&limit=10
```

**Response:**
```json
{
  "count": 150,
  "next": "http://localhost:8000/api/events/?page=2",
  "previous": null,
  "results": [
    {
      "id": 42,
      "camera": 1,
      "event_type": "fire",
      "ai_confidence": 87.34,
      "timestamp": "2026-04-21T14:32:00Z",
      "resolved": false
    }
  ]
}
```

---

#### **GET** `/api/events/{id}/` - Retrieve Specific Event

Get details of a single event.

**Request:**
```bash
curl http://localhost:8000/api/events/42/
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

---

#### **GET** `/api/cameras/` - List Cameras

Get all registered cameras.

**Request:**
```bash
curl http://localhost:8000/api/cameras/
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Main Entrance",
    "location": "Building A",
    "status": "active",
    "created_at": "2026-04-01T10:00:00Z"
  }
]
```

---

#### **POST** `/api/cameras/` - Register Camera

Add a new camera to the system.

**Request:**
```bash
curl -X POST http://localhost:8000/api/cameras/ \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Warehouse C",
    "location": "Building B"
  }'
```

**Response:**
```json
{
  "id": 2,
  "name": "Warehouse C",
  "location": "Building B",
  "status": "active",
  "created_at": "2026-04-21T14:32:00Z"
}
```

---

## 💻 Client Usage

### Python Webcam Client

Real-time testing with your system webcam.

#### Install Dependencies

```bash
pip install opencv-python requests
```

#### Run Webcam Detection

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
event_type=smoke  confidence=65.12
No fire (below threshold)
```

**Configuration** (edit `webcam_client.py`):
- `ENDPOINT`: AI service URL (default: `http://localhost:8001/predict`)
- `INTERVAL`: Frame capture interval in seconds (default: 2.0)

---

### Flutter Mobile Client

Cross-platform mobile application for iOS and Android.

#### Location
```
flutter_client/fire_detection_client.dart
```

#### Features
- 📸 Real-time camera capture
- 🔥 Fire detection inference
- 📱 Native device camera integration
- ⚠️ Connection error handling

#### Build & Run

```bash
# Configure AI service URL for your environment
flutter run --dart-define=AI_SERVICE_URL=http://10.0.2.2:8001

# For iOS simulator
flutter run --dart-define=AI_SERVICE_URL=http://localhost:8001

# For release build
flutter build apk --dart-define=AI_SERVICE_URL=https://your-backend.com:8001
```

#### API Integration

The Flutter client calls:
```
POST {AI_SERVICE_URL}/predict
- Sends: Image file (multipart)
- Receives: {event_type, confidence, detections}
```

---

### Terminal Demo Script

Display mock detection results with ASCII visualization.

```bash
python demo.py
```

---

## 🐳 Docker Deployment

### Service Startup Sequence

1. **PostgreSQL**: Initializes database
   - Health check: `pg_isready`
   - Retries: 10 times, 5-second intervals
   
2. **AI Service**: Loads YOLOv8 model
   - Health check: HTTP GET to `/`
   - Retries: 5 times, 10-second intervals
   
3. **Django Backend**: Waits for both services
   - Runs migrations: `python manage.py migrate`
   - Depends on: `db` (healthy) + `ai_service` (healthy)

### Health Checks

```bash
# Check all services
docker-compose ps

# View service logs
docker-compose logs -f backend
docker-compose logs -f ai_service
docker-compose logs -f db

# Restart specific service
docker-compose restart backend

# Stop all services
docker-compose down

# Full reset (caution: deletes database)
docker-compose down -v
docker-compose up --build
```

### Database Migrations

Migrations run automatically in `backend/entrypoint.sh`.

**Manual migration:**
```bash
docker-compose exec backend python manage.py migrate
```

**Create new migration:**
```bash
docker-compose exec backend python manage.py makemigrations
```

---

## 🔧 Development & Troubleshooting

### Services fail to start

**Solution:**
```bash
# Check logs for errors
docker-compose logs backend
docker-compose logs ai_service

# Ensure health checks pass
docker-compose ps
```

### AI service model not found

```bash
# Verify model exists
ls -la ai_service/best.pt

# Rebuild image
docker-compose build ai_service
docker-compose up ai_service
```

### Database connection errors

```bash
# Check DB health
docker-compose logs db

# Wait for DB to be ready
docker-compose up db

# Reset database (WARNING: deletes all data)
docker-compose down -v
docker-compose up --build
```

### Webcam client connection refused

```bash
# Verify services running
docker-compose ps

# Check AI service connectivity
curl http://localhost:8001/

# Check Django connectivity
curl http://localhost:8000/
```

### Out of memory during model loading

**Solution:** Increase Docker memory limit in `docker-compose.yml`:
```yaml
services:
  ai_service:
    mem_limit: 4g  # Adjust as needed
```

### Firebase notifications not working

1. Verify `firebase_credentials.json` path in backend
2. Check Firebase project configuration
3. Test notification delivery in Firebase console

---

## 📊 Project Status

### ✅ Completed Features

- **Django REST API**: Full-featured backend with authentication, camera management, event logging
- **FastAPI AI Service**: Production-ready YOLOv8 inference with health checks
- **Docker Deployment**: Complete containerization with orchestration
- **PostgreSQL Database**: Event persistence with migrations
- **Python Webcam Client**: Real-time testing capability
- **Firebase Integration**: Push notification framework
- **Multi-class Detection**: Fire, smoke, spark classification

### 🔄 In Development

- **Flutter Mobile Client**: UI/UX refinement and feature completion
- **Advanced Analytics**: Event statistics and trend analysis
- **Model Versioning**: A/B testing for improved accuracy
- **WebSocket Streaming**: Real-time frame transmission

### 🚧 Future Work

#### 📱 Mobile Enhancements
- Live video streaming to mobile devices
- Offline detection capability
- Advanced alert customization
- Event history analytics

#### 🧠 Model Improvements
- Expanded training dataset with diverse fire scenarios
- Fine-tuning for reduced false positives
- Support for additional detection classes (embers, heat haze)
- Quantized models for edge devices

#### 🎥 Streaming & Recording
- WebSocket integration for continuous streaming
- Multi-camera aggregated dashboard
- Event video archival
- Cloud storage integration

#### 📈 Analytics & Reporting
- Event statistics dashboard
- False positive rate tracking
- Performance metrics monitoring
- Automated incident reports

#### 🔐 Security & Compliance
- End-to-end encryption
- GDPR data retention policies
- Role-based access control (RBAC)
- Complete audit logging

---

## 📋 Configuration Reference

### Environment Variables (backend)

```bash
DB_HOST=db                          # PostgreSQL host
DB_PORT=5432                        # PostgreSQL port
DB_NAME=firedb                      # Database name
DB_USER=fireuser                    # Database user
DB_PASSWORD=firepassword            # Database password
AI_SERVICE_URL=http://ai_service:8001  # AI service URL
DEBUG=False                         # Django debug mode (production: False)
ALLOWED_HOSTS=*                     # Allowed hosts (production: specific hosts)
SECRET_KEY=your-secret-key          # Django secret key (change in production)
```

### Environment Variables (AI Service)

```bash
DJANGO_BACKEND_URL=http://backend:8000  # Backend URL for event posting
```

### Model Configuration

**File:** `ai_service/model.py`
- Model path: `ai_service/best.pt`
- Confidence threshold: 0.5 (50%)
- Device: GPU if available, CPU fallback

---

## 📚 Key Files Reference

| File | Purpose |
|------|---------|
| `docker-compose.yml` | Service orchestration & networking |
| `backend/requirements.txt` | Django dependencies |
| `ai_service/requirements.txt` | FastAPI/YOLO dependencies |
| `backend/entrypoint.sh` | Database initialization script |
| `ai_service/main.py` | FastAPI server endpoints |
| `ai_service/inference.py` | YOLO inference pipeline |
| `webcam_client.py` | Python testing client |
| `flutter_client/fire_detection_client.dart` | Flutter mobile app |

---

## 🤝 Contributing

Contributions are welcome! Please follow standard Git workflow:

```bash
# 1. Create feature branch
git checkout -b feature/your-feature

# 2. Commit changes
git commit -am 'Add feature description'

# 3. Push to branch
git push origin feature/your-feature

# 4. Submit pull request
```

### Development Guidelines

- Maintain Python 3.10+ compatibility
- Follow PEP 8 style guide
- Document API endpoints with examples
- Add unit tests for new features
- Update README.md for user-facing changes

---

## 📝 License

This project is part of a graduation capstone. All rights reserved.

---

## 👤 Author & Support

**Project Lead**: Mostafa Abdoelgohary

**Repository**: [fireguard-graduation-project](https://github.com/mostafaabdoelgohary2003AI/fireguard-graduation-project)

**Issues & Support**: Please create a GitHub issue for bugs or feature requests.

---

## 📖 Additional Resources

- [YOLO Documentation](https://docs.ultralytics.com/)
- [FastAPI Guide](https://fastapi.tiangolo.com/)
- [Django Documentation](https://www.djangoproject.com/)
- [Flutter Documentation](https://flutter.dev/docs)
- [Docker Compose Reference](https://docs.docker.com/compose/compose-file/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

---

**Last Updated**: April 26, 2026  
**Version**: 1.0.0
