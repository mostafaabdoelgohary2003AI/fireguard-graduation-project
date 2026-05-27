# Contributing to FireGuard

Thank you for your interest in contributing to FireGuard! This document provides guidelines and instructions for contributing to this graduation project.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Coding Standards](#coding-standards)
- [Branch Conventions](#branch-conventions)
- [Commit Messages](#commit-messages)

---

## Project Overview

FireGuard is a real-time fire and smoke detection platform composed of three independent services:

| Service | Technology | Directory |
| :--- | :--- | :--- |
| AI Service | FastAPI + YOLOv8 | `ai_service/` |
| Backend | Django REST Framework | `backend/` |
| Mobile App | Flutter | `frontend/` |

---

## Development Setup

### Prerequisites

| Tool | Version | Required For |
| :--- | :--- | :--- |
| Python | 3.10+ | Backend + AI Service |
| Flutter SDK | 3.9+ | Mobile app |
| Docker + Docker Compose | Latest stable | Full-stack deployment |
| YOLOv8 weights | `best.pt` | AI inference |

### Quick Start

```bash
# Clone the repository
git clone https://github.com/mostafaabdoelgohary2003AI/fireguard-graduation-project.git
cd "Fire Detection"

# Option A: Docker (full stack)
docker compose up --build

# Option B: Manual setup (see DEPLOYMENT.md or docs/deployment-guide.md)
```

### Backend Setup

```bash
cd backend
python -m venv .venv
source .venv/bin/activate        # Windows: .venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver 0.0.0.0:8000
```

### AI Service Setup

```bash
cd ai_service
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
# Ensure model/best.pt exists
uvicorn main:app --host 0.0.0.0 --port 8001
```

### Flutter Setup

```bash
cd frontend
flutter pub get
flutter run --dart-define=BACKEND_URL=http://10.0.2.2:8000  # Android emulator
```

---

## Project Structure

```
Fire Detection/
├── ai_service/         # FastAPI inference microservice
├── backend/            # Django REST API
├── frontend/           # Flutter mobile app
├── docs/               # Project documentation
├── screenshots/        # App screenshots
├── scripts/            # Developer tools (webcam_client, demo)
├── docker-compose.yml  # Docker orchestration
├── .env.example        # Environment variable template
└── README.md           # Main project documentation
```

---

## Coding Standards

### Python (Backend + AI Service)

- Follow **PEP 8** style guidelines
- Use **type hints** for function signatures
- Use **logging** (not `print()`) for application output
- Keep imports organized: stdlib → third-party → local

### Dart/Flutter (Mobile App)

- Follow the official [Dart Style Guide](https://dart.dev/effective-dart/style)
- Use **Provider** for state management
- Follow the **feature-first** directory organization
- Use `ScreenUtil` for responsive sizing

### General

- Write clear, descriptive commit messages
- Keep functions focused and small
- Add docstrings/comments for complex logic
- Do not commit secrets, credentials, or API keys

---

## Branch Conventions

| Branch | Purpose |
| :--- | :--- |
| `main` | Stable, deployment-ready code |
| `feature/<name>` | New feature development |
| `fix/<name>` | Bug fixes |
| `docs/<name>` | Documentation updates |

---

## Commit Messages

Follow this format:

```
<type>: <short description>

<optional body with more detail>
```

**Types:**

| Type | Usage |
| :--- | :--- |
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation changes |
| `style` | Code style / formatting |
| `refactor` | Code restructuring |
| `test` | Test additions/changes |
| `chore` | Build/config changes |

**Examples:**
```
feat: add fire event statistics endpoint
fix: handle missing FCM token on logout
docs: add Firebase setup guide
```

---

*FireGuard — Graduation Project, May 2026*
