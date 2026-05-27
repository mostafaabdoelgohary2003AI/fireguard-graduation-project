# FireGuard — Deployment Guide

> Practical reference for deploying the backend, AI service, and Flutter app.  
> Active database: **SQLite**. Web server: **Gunicorn** (3 workers). Orchestration: **Docker Compose**.

---

## Table of Contents

1. [Prerequisites](#1-prerequisites)
2. [Environment Variables](#2-environment-variables)
3. [Docker Deployment (recommended)](#3-docker-deployment-recommended)
4. [Manual Backend Deployment](#4-manual-backend-deployment)
5. [Manual AI Service Deployment](#5-manual-ai-service-deployment)
6. [SQLite Notes](#6-sqlite-notes)
7. [Firebase Setup](#7-firebase-setup)
8. [Flutter — Backend Connection](#8-flutter--backend-connection)
9. [PythonAnywhere Hosting](#9-pythonanywhere-hosting)
10. [Troubleshooting](#10-troubleshooting)

---

## 1. Prerequisites

| Tool | Min version | Purpose |
| :--- | :--- | :--- |
| Docker + Docker Compose | latest stable | One-command stack |
| Python | 3.10+ | Manual deploy / local dev |
| Flutter SDK | 3.9+ | Mobile app build |
| YOLOv8 weights file | — | `ai_service/model/best.pt` |

---

## 2. Environment Variables

### Backend (`backend/.env` or shell environment)

| Variable | Default | Notes |
| :--- | :--- | :--- |
| `SECRET_KEY` | `unsafe-dev-key-change-me` | **Change in production** |
| `ALLOWED_HOSTS` | `bodareda0001.pythonanywhere.com,localhost,127.0.0.1,0.0.0.0` | Comma-separated |
| `FIREBASE_CREDENTIALS_PATH` | `<BASE_DIR>/firebase_credentials.json` | Optional — push skipped if missing |
| `DB_HOST` / `DB_PORT` / `DB_NAME` / `DB_USER` / `DB_PASSWORD` | from compose | Reserved for future Postgres — **not used by Django** |
| `AI_SERVICE_URL` | `http://ai_service:8001` | Internal Docker DNS |

> `DEBUG` is hardcoded to `False` in `fireguard/settings.py`. Do not override it to `True` in production.

### AI Service

| Variable | Default | Notes |
| :--- | :--- | :--- |
| `DJANGO_BACKEND_URL` | `https://bodareda0001.pythonanywhere.com` | Where detected events are posted |

### Flutter (build-time `--dart-define`)

| Define | Default | Notes |
| :--- | :--- | :--- |
| `BACKEND_URL` | `https://bodareda0001.pythonanywhere.com` | REST base URL |

---

## 3. Docker Deployment (recommended)

```bash
# Clone
git clone https://github.com/mostafaabdoelgohary2003AI/fireguard-graduation-project.git
cd "Fire Detection"

# Place model weights
mkdir -p ai_service/model
cp /path/to/best.pt ai_service/model/best.pt

# (Optional) Place Firebase credentials
cp /path/to/firebase_credentials.json backend/firebase_credentials.json

# Build and start all services
docker compose up --build

# Run in background
docker compose up --build -d
```

**Service ports after startup:**

| Service | Port | Health check URL |
| :--- | :--- | :--- |
| Backend (Gunicorn) | `8000` | `http://localhost:8000/` |
| AI Service (Uvicorn) | `8001` | `http://localhost:8001/` |
| PostgreSQL (unused by Django) | `5432` | internal only |

### Useful commands

```bash
# Tail logs
docker compose logs -f backend
docker compose logs -f ai_service

# Run a Django management command
docker compose exec backend python manage.py createsuperuser

# Apply new migrations after a model change
docker compose exec backend python manage.py migrate

# Stop stack
docker compose down

# Stop and wipe volumes
docker compose down -v
```

---

## 4. Manual Backend Deployment

```bash
cd backend
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate

pip install -r requirements.txt

# Mandatory first-time steps
python manage.py migrate --noinput
python manage.py collectstatic --noinput
python manage.py createsuperuser  # for Django admin at /admin/

# Development server
python manage.py runserver 0.0.0.0:8000

# Production (matches Docker entrypoint exactly)
gunicorn fireguard.wsgi:application --bind 0.0.0.0:8000 --workers 3
```

### What `entrypoint.sh` does (Docker startup)

```sh
#!/bin/sh
set -e
python manage.py migrate --noinput
python manage.py collectstatic --noinput || true
exec gunicorn fireguard.wsgi:application --bind 0.0.0.0:8000 --workers 3
```

Both `migrate` and `collectstatic` run automatically on every container start. This is safe because Django migrations are idempotent.

### Seeding required data

Before the AI service can create events, at least one **Zone** and one **Camera** must exist. Use the Django admin at `/admin/` or the API:

```bash
# 1. Create a superuser token
curl -X POST http://localhost:8000/api/auth/login/ \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"yourpassword"}'

# 2. Create a zone (requires is_staff=true)
curl -X POST http://localhost:8000/api/cameras/zones/ \
  -H "Authorization: Token <token>" \
  -H "Content-Type: application/json" \
  -d '{"name":"Main Building","description":"Ground floor"}'

# 3. Create a camera in that zone (zone id = 1)
curl -X POST http://localhost:8000/api/cameras/cameras/ \
  -H "Authorization: Token <token>" \
  -H "Content-Type: application/json" \
  -d '{"name":"Entrance Cam","location":"Gate 1","zone":1,"status":"online"}'
```

---

## 5. Manual AI Service Deployment

```bash
cd ai_service
python -m venv .venv
source .venv/bin/activate

pip install -r requirements.txt

# Place model weights at the expected path
mkdir -p model
cp /path/to/best.pt model/best.pt

# (Optional) point at a local backend
export DJANGO_BACKEND_URL=http://localhost:8000

uvicorn main:app --host 0.0.0.0 --port 8001
```

> The service logs every prediction at `INFO` level: `camera=<id> event_type=<type> confidence=<n> detections=<count>`.

### Model path

```python
# ai_service/model.py
MODEL_PATH = "model/best.pt"      # relative to the working directory
CONF_THRESHOLD = 0.5              # detections below this are discarded
```

The model is loaded once at startup and warmed up with a dummy pass. The first real request is therefore fast.

---

## 6. SQLite Notes

Django is configured for **SQLite only**. The database file lives at:

```
backend/db.sqlite3
```

This file is created automatically on first `migrate`.

### In Docker

The file lives **inside the container** at `/app/db.sqlite3`. To persist it across `docker compose down` runs, add a bind mount in `docker-compose.yml`:

```yaml
services:
  backend:
    volumes:
      - ./backend/db.sqlite3:/app/db.sqlite3
```

### Backups

```bash
# Copy out of running container
docker compose cp backend:/app/db.sqlite3 ./backup_$(date +%F).sqlite3

# Or directly if running manually
cp backend/db.sqlite3 backup_$(date +%F).sqlite3
```

### Migrating to PostgreSQL (future)

1. Update `DATABASES` in `fireguard/settings.py` to the `postgresql` engine.
2. Set `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_PORT`.
3. Run `python manage.py migrate`.
4. All migration files are already written — no schema changes needed.

---

## 7. Firebase Setup

Firebase powers FCM push notifications. The backend gracefully skips push dispatch if credentials are absent — the rest of the app keeps working.

### Backend

1. Go to **Firebase Console → Project Settings → Service Accounts → Generate new private key**.
2. Save the downloaded JSON as:
   ```
   backend/firebase_credentials.json
   ```
3. The path is configurable:
   ```bash
   export FIREBASE_CREDENTIALS_PATH=/absolute/path/to/firebase_credentials.json
   ```
4. Firebase is initialized in `notifications/apps.py → AppConfig.ready()`:
   ```python
   from fireguard.firebase import initialize_firebase
   initialize_firebase()
   ```
   It is idempotent — safe to call multiple times.

### Flutter

| Platform | Required file | Location |
| :--- | :--- | :--- |
| Android | `google-services.json` | `frontend/android/app/` |
| iOS | `GoogleService-Info.plist` | `frontend/ios/Runner/` |

Both files come from **Firebase Console → Project Settings → Your apps**.

### Notification channel

Android notifications go through the `alerts` channel (high importance, red LED, `fullScreenIntent`). The channel id is hardcoded in both the backend (`fcm.py`) and the Flutter app (`notification_service.dart`) — they must match.

### Alarm sound asset

Drop a royalty-free MP3 siren at:

```
frontend/assets/sounds/alarm.mp3
```

If missing, `AlarmService` silently falls back to vibration only.

---

## 8. Flutter — Backend Connection

The base URL is injected at build time:

```bash
# Android emulator → host machine
flutter run --dart-define=BACKEND_URL=http://10.0.2.2:8000

# iOS simulator
flutter run --dart-define=BACKEND_URL=http://localhost:8000

# Physical device on the same Wi-Fi
flutter run --dart-define=BACKEND_URL=http://192.168.x.x:8000

# Production
flutter run --dart-define=BACKEND_URL=https://your-domain.com

# Release APK
flutter build apk --dart-define=BACKEND_URL=https://your-domain.com
```

Without `--dart-define`, the app falls back to `https://bodareda0001.pythonanywhere.com`.

### FCM token registration flow

After every successful login or register, the Flutter app automatically calls:

```
POST /api/notifications/register-device/
{ "token": "<fcm_token>", "platform": "android" | "ios" }
```

On logout it calls `DELETE /api/notifications/unregister-device/`. No manual handling required.

---

## 9. PythonAnywhere Hosting

The project is pre-configured for [PythonAnywhere](https://www.pythonanywhere.com) free-tier hosting.

1. Upload or `git clone` the `backend/` directory.
2. Create a virtual environment and `pip install -r requirements.txt`.
3. In the PythonAnywhere **Web** tab:
   - Set **WSGI file** to point to `fireguard/wsgi.py`.
   - Set the **virtualenv** path.
4. Add a `.env` file in `backend/` with `SECRET_KEY` and, optionally, `FIREBASE_CREDENTIALS_PATH`.
5. Run `python manage.py migrate` from the PythonAnywhere console.
6. **Static files**: configure the `/static/` alias to point to `backend/staticfiles/`.

> PythonAnywhere free tier does not allow outbound connections to Firebase. Use a paid tier or deploy the backend elsewhere for live push notifications.

---

## 10. Troubleshooting

### Services fail to start (Docker)

```bash
docker compose logs backend
docker compose logs ai_service
docker compose ps   # check health status
```

### Backend: `OperationalError: no such table`

Migrations have not run. Execute:

```bash
# Docker
docker compose exec backend python manage.py migrate

# Manual
python manage.py migrate
```

### AI service: model not found

```
FileNotFoundError: model/best.pt
```

Verify the file is at `ai_service/model/best.pt` (not `ai_service/best.pt`).

```bash
ls ai_service/model/best.pt
```

Rebuild the Docker image after placing the file:

```bash
docker compose build ai_service && docker compose up ai_service
```

### AI service: memory error on model load

Increase container memory in `docker-compose.yml`:

```yaml
services:
  ai_service:
    mem_limit: 4g
```

### Push notifications not delivered

1. Confirm `backend/firebase_credentials.json` exists and is valid.
2. Check Django startup logs for `[Firebase] Initialized successfully.` vs `[Firebase] Initialization failed: ...`.
3. Confirm the Flutter app has `google-services.json` / `GoogleService-Info.plist`.
4. Confirm the user has `fire_alerts = true` in `NotificationPreference` (default: `true`).
5. Test with the dev endpoint:
   ```bash
   curl -X POST http://localhost:8000/api/notifications/test-push/ \
     -H "Authorization: Token <token>" \
     -H "Content-Type: application/json" \
     -d '{"token":"<fcm_token>"}'
   ```

### Flutter: `Connection refused` / `SocketException`

- Check `BACKEND_URL` points to the right address (emulator: `10.0.2.2`, not `localhost`).
- Verify the backend is running: `curl http://<BACKEND_URL>/`.
- Ensure port `8000` is not blocked by a firewall.

### `CORS` errors from browser / other clients

`CORS_ALLOW_ALL_ORIGINS = True` is set in `settings.py`. If you restrict it, add the client origin to `CORS_ALLOWED_ORIGINS`.

### `DisallowedHost` error

Add the server's hostname or IP to `ALLOWED_HOSTS` (via the env variable or directly in `settings.py`).

---

*Last updated: May 2026 — matches the repository's production configuration.*
