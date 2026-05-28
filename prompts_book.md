<div align="center">

# 🔥 FireGuard — Graduation Project Prompts Book

### AI-Powered Fire & Smoke Detection and Emergency Alert System

---

**5 Master Prompts for Claude Sonnet / Opus**

Each prompt generates one complete team chapter (~15–25 pages)
Optimized for token limits · IEEE citations · Word-ready formatting

---

</div>

<br/>

## 📌 How to Use This File

| Step | Action |
|:-----|:-------|
| 1 | Copy the **entire prompt** from a team section below |
| 2 | Paste it into a new Claude Sonnet 4 / Opus conversation |
| 3 | Replace all `[X]` placeholders with your real project data |
| 4 | Review the output, then ask Claude to revise or expand sections |
| 5 | Export to Word, apply formatting, insert real screenshots/diagrams |
| 6 | Verify every citation — never submit AI-generated references without checking |

> ⚠️ **Important**: These are **prompts**, not answers. Each prompt is designed to generate ~15–25 pages of structured academic content when submitted to Claude.

---

<br/>

## 📋 Table of Contents

| # | Team Prompt | Covers |
|:--|:-----------|:-------|
| 1 | [🧠 AI Team](#1--ai-team-chapter) | Dataset, Roboflow, YOLOv8, PyTorch, inference pipeline, OpenCV, camera integration, model evaluation |
| 2 | [🗄️ Backend Team](#2--backend-team-chapter) | Django, DRF APIs, authentication, Firebase notifications, system architecture |
| 3 | [📱 Frontend / UI Team](#3--frontend--ui-team-chapter) | Flutter, state management, UI/UX, screens, navigation, emergency alert UX |
| 4 | [💾 Database Team](#4--database-team-chapter) | SQLite3, Django ORM, schema design, ERD, migrations, query patterns |
| 5 | [🐳 Deployment Team](#5--deployment-team-chapter) | Docker, Docker Compose, FastAPI/Uvicorn, Gunicorn, testing, results, challenges, future work |

---

<br/>

---

# 1 — 🧠 AI Team Chapter

<details>
<summary><b>Click to expand full prompt (~15–25 pages output)</b></summary>

```
You are an expert academic engineering writer with deep expertise in deep learning,
computer vision, and object detection. You are writing a chapter for a graduation
project report/book submitted to a university engineering faculty.

Write the COMPLETE AI / COMPUTER VISION CHAPTER for the following project.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM OVERVIEW (for context only — focus this chapter on the AI pipeline):
- Microservice architecture: FastAPI AI Service + Django Backend + Flutter Mobile App
- Database: SQLite3 (zero-configuration, file-based)
- Push notifications: Firebase Cloud Messaging (FCM)
- Camera: External WiFi camera connected through USB and used as webcam input
  during live demo/testing (accessed via OpenCV VideoCapture(0))
- Containerization: Docker + Docker Compose

AI SERVICE TECHNICAL DETAILS:
- Framework: FastAPI (Python 3.10) served by Uvicorn (single worker)
- Model: YOLOv8 (Ultralytics implementation) — custom-trained on fire/smoke dataset
- Runtime: PyTorch (CPU inference in Docker; GPU optional for local training)
- Weights file: best.pt (~6 MB, serialized via torch.save)
- Target classes: fire (class 0), smoke (class 1) — 2 classes only
- Confidence threshold: 0.5 (50%)
- Dataset management: Roboflow (annotation, preprocessing, augmentation, export)
- Image processing: OpenCV (opencv-python-headless in container)
- Inference endpoint: POST /predict (multipart image upload)
- Model warmup: dummy inference on startup to pre-allocate memory
- Backend notification: if confidence > 50%, AI service POSTs event to Django backend

CAMERA INTEGRATION:
- camera.py: Direct local inference mode — opens webcam via cv2.VideoCapture(0),
  runs YOLO locally, posts detected events to Django backend, 10-second cooldown
  between alerts, live visualization window
- webcam_client.py: Client-server mode — captures frames, sends via HTTP POST
  to AI service /predict endpoint every 2 seconds
- demo.py: Simulated detection mode — sends pre-captured images for testing
  without physical camera

══════════════════════════════════════════════════════════
CHAPTER STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

1. CHAPTER INTRODUCTION (500–800 words)
   - Role of the AI component as the "brain" of FireGuard
   - Why computer vision was chosen over traditional sensors (smoke detectors, heat sensors)
   - End-to-end AI pipeline overview at a high level:
     Camera → Frame capture → Preprocessing → YOLOv8 Inference → Post-processing →
     Event decision → Backend notification
   - Include a Mermaid flowchart of the complete AI pipeline
   - Include a KEY DESIGN DECISIONS TABLE:
     | Decision | Options Considered | Chosen | Justification |
     (Cover: model architecture, input size, confidence threshold, target classes,
      preprocessing approach)
   - Chapter roadmap (list the subsections that follow)

2. DATASET COLLECTION AND ANNOTATION (1500–2000 words)
   - Data collection strategy: sources (public datasets, web scraping, custom captures)
   - Diversity: indoor, outdoor, day, night, different fire types, negative samples
   - Include a table: "Table X: Dataset Sources" — Source | Type | Image Count | Notes
   - Annotation methodology: Roboflow annotation interface, YOLO format
   - YOLO annotation format explanation with mathematical formulation:
     center_x = (x_min + x_max) / (2 × image_width)
   - Include example annotation file in a code block
   - Dataset statistics:
     Total images [X], Train/Val/Test split [X]%/[X]%/[X]%
     Class distribution: fire [X] instances, smoke [X] instances
   - Include a table: "Table X: Dataset Split Summary"
   - Dataset challenges: class imbalance, ambiguous cases (steam vs. smoke),
     small object detection, varying resolutions
   - Figure placeholders for annotated sample images

3. ROBOFLOW PREPROCESSING PIPELINE (1000–1500 words)
   - What Roboflow is and why it was chosen
   - Alternative tools comparison table: Roboflow vs. LabelImg vs. CVAT vs. Labelme
   - Preprocessing steps: auto-orient, resize to [X]×[X], normalization
   - Include a Mermaid flowchart:
     Raw Images → Upload → Annotate → Preprocess → Augment → Export
   - Augmentation techniques table:
     | Technique | Parameters | Purpose |
     (horizontal flip, rotation ±15°, brightness ±25%, blur up to 2px,
      noise injection, mosaic)
   - Figure placeholders for before/after augmentation examples
   - Dataset versioning and export to YOLOv8 PyTorch format
   - Export directory structure: train/images, train/labels, valid/, test/
   - data.yaml file explanation

4. YOLOv8 TRAINING METHODOLOGY (2000–2500 words)
   - YOLOv8 variant selection table (nano/small/medium/large/xlarge):
     | Variant | Parameters | FLOPs | mAP (COCO) | Chosen? |
   - Training hyperparameters table:
     | Parameter | Value | Justification |
     (epochs, batch size, image size 640, learning rate, optimizer, weight decay,
      momentum, warmup epochs, augmentation params)
   - Transfer learning strategy: COCO pre-trained weights, fine-tuning approach
   - Training process: hardware specs, training command example (Python code block),
     monitoring (loss curves, mAP progression), early stopping
   - Loss functions with mathematical formulas:
     * Box loss (CIoU)
     * Classification loss (Binary Cross-Entropy)
     * Distribution Focal Loss (DFL)
   - Evaluation metrics with formulas:
     * Precision = TP / (TP + FP)
     * Recall = TP / (TP + FN)
     * F1 = 2 × (P × R) / (P + R)
     * mAP@0.5 and mAP@0.5:0.95 explanation
   - Confusion matrix description
   - Training results summary table with placeholder metrics
   - Figure placeholders: PR curve, confusion matrix, F1-confidence curve,
     training loss curve, mAP progression over epochs
   - Model export: best.pt vs. last.pt, model size, inference speed benchmarks

5. PYTORCH IMPLEMENTATION DETAILS (800–1200 words)
   - PyTorch framework overview and role in the ML ecosystem
   - Comparison table: PyTorch vs. TensorFlow for object detection
   - Ultralytics library: how it wraps PyTorch, YOLO class API
     (load, train, predict, export)
   - Model serialization (.pt files — torch.save)
   - Inference runtime: GPU vs. CPU device selection, tensor operations,
     Non-Maximum Suppression (NMS)
   - Custom integration: how best.pt is loaded in FireGuard,
     warmup strategy, thread safety
   - Include code snippets from model.py

6. INFERENCE PIPELINE (1500–2000 words)
   - Complete pipeline Mermaid flowchart:
     HTTP POST /predict → Validate → Read Bytes → Decode (OpenCV) → BGR→RGB →
     YOLO Inference → Filter Classes → Confidence Check → Return + Notify Backend
   - Step-by-step breakdown with code walkthrough:
     a. Image reception (FastAPI UploadFile)
     b. Decoding (np.frombuffer → cv2.imdecode → cv2.cvtColor)
     c. Model inference (model(image, conf=0.5, verbose=False))
     d. Result parsing (boxes, labels, confidence)
     e. Target class filtering (fire and smoke only)
     f. Best detection selection (highest confidence)
     g. Threshold decision (>50% → notify backend)
     h. Backend notification (HTTP POST: camera_id, event_type, ai_confidence)
     i. Response construction (JSON: event_type, confidence, detections[])
   - Error handling: invalid image, empty data, model failure, backend failure
   - Performance table: "Inference Pipeline Timing Breakdown"
     | Step | Average Time (ms) |
     (decode, color conversion, YOLO inference, post-processing, total)

7. OPENCV INTEGRATION (800–1200 words)
   - OpenCV overview and role in computer vision
   - opencv-python-headless for server (no GUI dependencies)
   - Image processing pipeline:
     * np.frombuffer(bytes, dtype=np.uint8)
     * cv2.imdecode(buffer, cv2.IMREAD_COLOR)
     * cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
     * Why BGR→RGB is necessary (OpenCV BGR default, YOLO expects RGB)
   - Webcam integration: cv2.VideoCapture(0), cap.read(), cv2.imencode
   - Detection visualization: result.plot(), cv2.imshow for demo
   - Include code snippets and a Mermaid image processing flow diagram

8. CAMERA INTEGRATION WORKFLOW (1000–1500 words)
   - Hardware: External WiFi camera connected through USB and used as webcam input
     during live demo/testing. Appears as standard webcam (video device index 0).
   - Integration Mode 1 — Direct Detection (camera.py):
     Camera → VideoCapture(0) → YOLO local inference → cooldown → POST event to backend
     Include Mermaid sequence diagram
   - Integration Mode 2 — Client-Server (webcam_client.py):
     Camera → VideoCapture(0) → capture every 2s → HTTP POST to /predict → AI service
     Include Mermaid sequence diagram
   - Integration Mode 3 — Simulation (demo.py):
     Pre-captured images → HTTP POST to /predict → testing without camera
   - Comparison table of the three integration modes
   - Demo workflow: connect camera → start Docker → run camera.py → detect → alert
   - Challenges: driver compatibility, frame rate, latency

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Section headings: 14 pt bold
- Chapter title: 16 pt bold
- Line spacing: 1.5
- Text alignment: justified
- All figures must have captions: "Figure X.Y: [Description]"
- All tables must have captions: "Table X.Y: [Description]"
- Suggest page breaks between major sections
- Number all sections hierarchically (e.g., 5.1, 5.1.1, 5.1.2)

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Include a REFERENCES section at the end of this chapter with:
  * Real YOLO papers (Redmon et al. 2016, Jocher et al. for YOLOv5/v8)
  * Real PyTorch references (Paszke et al. 2019)
  * Real OpenCV references (Bradski 2000)
  * Real fire detection papers from IEEE/Springer/Elsevier
  * Official Ultralytics, Roboflow, FastAPI documentation URLs with access dates
  * Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.
  * Minimum 15 references for this chapter

DIAGRAMS AND VISUALS:
- Include Mermaid diagrams wherever specified
- Include tables wherever specified
- Include figure placeholders: "Figure X.Y: [Description] — [insert screenshot]"
- Suggest infographics where applicable

TOKEN OPTIMIZATION:
- Target output: approximately 15–25 Word pages
- If the chapter is too long for a single generation, indicate clearly where
  to split and provide a continuation prompt
```

</details>

---

<br/>

---

# 2 — 🗄️ Backend Team Chapter

<details>
<summary><b>Click to expand full prompt (~15–25 pages output)</b></summary>

```
You are an expert academic engineering writer specializing in backend development,
REST API design, web security, and push notification systems. You are writing a
chapter for a graduation project report/book submitted to a university engineering
faculty.

Write the COMPLETE BACKEND CHAPTER for the following project.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM OVERVIEW (for context only — focus this chapter on the backend):
- Microservice architecture: FastAPI AI Service + Django Backend + Flutter Mobile App
- Database: SQLite3 (zero-configuration, file-based, no PostgreSQL)
- Push notifications: Firebase Cloud Messaging (FCM)
- Camera: External WiFi camera connected through USB and used as webcam input
  during live demo/testing
- Containerization: Docker + Docker Compose

BACKEND TECHNICAL DETAILS:
- Framework: Django 5.2 + Django REST Framework (DRF) 3.17
- Server: Gunicorn 21.2 (3 sync workers, --bind 0.0.0.0:8000)
- Database: SQLite3 (db.sqlite3 file inside backend container)
- Authentication: DRF Token Authentication (rest_framework.authtoken)
- Firebase: firebase-admin SDK (Python) for push notifications
- CORS: django-cors-headers (CORS_ALLOW_ALL_ORIGINS = True in development)
- Environment: python-dotenv for .env loading
- Docker: python:3.10-slim base image
- Startup: entrypoint.sh (migrate → collectstatic → exec gunicorn)

DJANGO APPS:
- accounts: UserProfile (phone, avatar — OneToOneField to auth.User)
- cameras: Zone (name, description), Camera (name, location, stream_url, thumbnail, status)
- events: FireEvent (event_type, status, ai_confidence, snapshot, notes, detected_at, resolved_at)
- notifications: FCMDevice (token, platform, is_active), NotificationPreference (fire/resolved/false_alarm/sound flags)

API STRUCTURE:
- Base URL: http://localhost:8000/api/
- Authentication: Token Authentication (Authorization: Token <key>)
- Response format: JSON
- Pagination: PageNumberPagination (PAGE_SIZE=20)

API GROUPS:
1. Auth APIs (/api/auth/)
   - POST /register/ — create new user account
   - POST /login/ — authenticate and return token
   - POST /logout/ — invalidate token
   - GET /profile/ — get current user profile
   - PUT /profile/update/ — update profile (phone, avatar)
   - POST /change-password/ — change password

2. Cameras APIs (/api/cameras/)
   - GET /zones/ — list all zones
   - POST /zones/ — create zone
   - GET /cameras/ — list all cameras
   - POST /cameras/ — create camera
   - DELETE /cameras/<id>/ — delete camera
   - PATCH /cameras/<id>/toggle-status/ — toggle online/offline
   - GET /cameras/stats/ — camera statistics

3. Events APIs (/api/events/)
   - GET / — list all events (paginated)
   - POST / — create event (used by AI service)
   - GET /<id>/ — get event detail
   - PATCH /<id>/resolve/ — mark as resolved
   - PATCH /<id>/false-alarm/ — mark as false alarm
   - GET /active/ — list active events
   - GET /stats/ — event statistics

4. Notifications APIs (/api/notifications/)
   - POST /register-device/ — register FCM token
   - DELETE /unregister-device/ — unregister FCM token
   - GET /preferences/ — get notification preferences
   - PUT /preferences/ — update notification preferences
   - POST /test-push/ — send test notification

FIREBASE CONTEXT:
- Firebase initialization in Django (firebase.py → AppConfig.ready())
- Idempotent init with firebase_admin._apps check
- FCM functions: send_fire_alert_to_all(event), send_resolved_alert(event), send_test_push(token)
- Multicast: send_each_for_multicast() to all opted-in devices
- Notification types: fire_alert, smoke_alert, event_resolved
- Payload: notification block + data block (JSON)
- Graceful degradation: if Firebase init fails, app continues without push

SECURITY CONTEXT:
- DRF Token Authentication (rest_framework.authtoken)
- Default permission: IsAuthenticated on all endpoints
- Password hashing: Django PBKDF2 + SHA256
- No plaintext passwords stored
- Firebase credentials: JSON file (firebase_credentials.json)

══════════════════════════════════════════════════════════
CHAPTER STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

1. CHAPTER INTRODUCTION (800–1200 words)
   - Backend role: central business logic, data persistence, API gateway,
     event receiver from AI service, notification dispatcher
   - Technology justification table:
     | Technology | Version | Purpose | Why Chosen |
     (Django, DRF, Gunicorn, SQLite3, firebase-admin, python-dotenv, django-cors-headers)
   - Django project structure overview:
     * fireguard/ (settings.py, urls.py, firebase.py, wsgi.py)
     * accounts/, cameras/, events/, notifications/
   - Include a Mermaid diagram showing Django app structure and relationships
   - System architecture overview: how the backend connects AI service, database,
     Firebase, and mobile app
   - Include a Mermaid architecture diagram:
     Camera → AI Service → Backend → SQLite3
     Backend → Firebase → Flutter App
     Flutter App → Backend (REST API)

2. DJANGO REST FRAMEWORK APIs (2000–2500 words)
   - API design principles: RESTful conventions, resource naming, HTTP method semantics,
     status codes (200, 201, 400, 401, 403, 404, 500)
   - ENDPOINT DOCUMENTATION — for EACH endpoint, provide:
     * HTTP Method + URL
     * Description
     * Authentication required (Yes/No)
     * Request body (JSON example in code block)
     * Response body (JSON example in code block)
     * Status codes
     Present as formatted tables or structured blocks
   - Serializer architecture: how DRF serializers validate and transform data,
     key serializers (UserSerializer, CameraSerializer, FireEventSerializer, FCMDeviceSerializer),
     nested serialization
   - View architecture: ViewSets vs. APIViews, custom @action decorators,
     permission classes
   - URL routing: Django URL config, DRF Router, URL pattern → view mapping table
   - Include a Mermaid diagram showing URL routing structure
   - Include JSON code blocks for request/response examples

3. AUTHENTICATION AND SECURITY (1200–1500 words)
   - Authentication flow with Mermaid sequence diagram:
     Register → Hash password → Store → Login → Validate → Generate Token → Return →
     Subsequent requests with "Authorization: Token <key>" → Logout → Delete token
   - Token-based authentication:
     * How DRF TokenAuthentication works
     * Token storage (authtoken_token table)
     * Token in HTTP headers
     * Token invalidation on logout
     * Comparison with JWT — why token auth was chosen
   - Authorization: IsAuthenticated class, admin via Django admin (is_staff)
   - Mobile-side security:
     * flutter_secure_storage for encrypted token storage
     * Dio interceptor for automatic token injection
     * Auto-logout on 401
   - Security assessment table:
     | Threat | Current Status | Mitigation | Priority |
     (HTTPS, CORS restriction, Firebase credentials, rate limiting — noted as future work)

4. FIREBASE NOTIFICATION SYSTEM (1500–2000 words)
   - FCM overview: what it is, how it works (client → FCM server → device)
   - Comparison table: FCM vs. OneSignal vs. Pusher vs. custom WebSocket
   - Backend implementation:
     * Firebase init in Django (firebase.py → AppConfig.ready())
     * Idempotent init with _apps check
     * Dispatch functions: send_fire_alert_to_all, send_resolved_alert, send_test_push
     * Notification payload JSON example (notification block + data block)
   - Include Mermaid sequence diagram:
     Event Created → Filter Opted-in Users → Collect Tokens → Multicast → FCM → Devices
   - Mobile implementation summary:
     * Firebase init in Flutter, token lifecycle, foreground/background handling
     * Local notifications (flutter_local_notifications)
     * AlarmService: siren + vibration on fire alerts
     * Full-screen alert navigation
   - Notification preferences: NotificationPreference model, user opt-in/opt-out,
     backend filters devices by preferences before sending
   - Platform comparison table: Android vs. iOS notification behavior
     (notification channels, importance levels, APNS priority)

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Section headings: 14 pt bold
- Chapter title: 16 pt bold
- Line spacing: 1.5
- Text alignment: justified
- All figures must have captions: "Figure X.Y: [Description]"
- All tables must have captions: "Table X.Y: [Description]"
- Suggest page breaks between major sections
- Number all sections hierarchically (e.g., 6.1, 6.1.1, 6.1.2)

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Include a REFERENCES section at the end of this chapter with:
  * Real Django documentation references (djangoproject.com)
  * Real DRF documentation references
  * Real Firebase documentation references
  * Real web security references (OWASP, RFC standards)
  * Real REST API design references (Fielding 2000)
  * Real Gunicorn documentation references
  * Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.
  * Minimum 12 references for this chapter

DIAGRAMS AND VISUALS:
- Include Mermaid diagrams wherever specified
- Include tables wherever specified
- Include figure placeholders: "Figure X.Y: [Description] — [insert screenshot]"
- Include JSON code blocks for all API examples

TOKEN OPTIMIZATION:
- Target output: approximately 15–25 Word pages
- If the chapter is too long for a single generation, indicate clearly where
  to split and provide a continuation prompt
```

</details>

---

<br/>

---

# 3 — 📱 Frontend / UI Team Chapter

<details>
<summary><b>Click to expand full prompt (~15–25 pages output)</b></summary>

```
You are an expert academic engineering writer specializing in mobile application
development, Flutter, state management, and UI/UX design. You are writing a
chapter for a graduation project report/book submitted to a university engineering
faculty.

Write the COMPLETE FRONTEND / FLUTTER CHAPTER for the following project.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM OVERVIEW (for context only — focus this chapter on the mobile app):
- Microservice architecture: FastAPI AI Service + Django Backend + Flutter Mobile App
- Database: SQLite3 (zero-configuration, file-based, no PostgreSQL)
- Push notifications: Firebase Cloud Messaging (FCM)
- Camera: External WiFi camera connected through USB and used as webcam input
  during live demo/testing
- Containerization: Docker + Docker Compose

FLUTTER TECHNICAL DETAILS:
- Framework: Flutter 3.9+ / Dart ^3.9
- Architecture: Feature-first clean architecture
- State management: Provider ^6.1.5 (ChangeNotifier-based)
- HTTP client: Dio ^5.7.0 with auth interceptor
- Navigation: go_router ^17.2.1
- Push notifications: firebase_core ^3.13 + firebase_messaging ^15.2
- Local notifications: flutter_local_notifications ^18.0
- Responsive sizing: flutter_screenutil ^5.9.3
- Secure storage: flutter_secure_storage ^9.2.2
- Audio: audioplayers ^6.4.0 (alarm siren)
- Haptic: vibration ^3.1.0

FEATURE MODULES:
- splash: animated logo, auto-auth check
- auth: login, signup, forgot_password
- home: dashboard stats, camera network, recent activity, simulate alert toggle
- cameras: camera grid, add/delete camera
- alert: FULL-SCREEN emergency — pulsing red background, event details,
  "Mark Resolved" / "False Alarm" buttons, siren + vibration
- notification: tabbed history (All, Fire, Smoke, Resolved)
- settings: notification preferences, profile, logout

CORE MODULES:
- constant, models, navigation, services, theme, widgets

PROVIDERS:
- AuthProvider — login state, user data, token management
- HomeProvider — dashboard stats, recent activity, system status
- CameraProvider — camera list, CRUD operations, stats
- AlertProvider — active alert state, siren control, resolution actions
- NotificationProvider — notification history, tab filtering, preferences
- SplashProvider — initial auth check, auto-navigation

UI/UX CONTEXT:
- Dark theme with emergency-focused color palette
- Custom color system: AppColors class
- Typography: AppTextStyle custom class
- Emergency UX: full-screen alert with pulsing red, siren audio, vibration
- Color psychology: red = danger, green = safe, amber = warning

══════════════════════════════════════════════════════════
CHAPTER STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

1. CHAPTER INTRODUCTION (800–1200 words)
   - What Flutter is and its advantages for this project
   - Cross-platform benefit (Android + iOS from single codebase)
   - Widget-based declarative UI approach
   - Comparison table: Flutter vs. React Native vs. Native Development
   - Project structure: feature-first directory organization
   - Include a directory tree diagram showing Core vs. Feature separation
   - Include a Mermaid diagram showing feature module dependencies
   - Key dependencies table:
     | Package | Version | Purpose | Justification |
   - Chapter roadmap

2. STATE MANAGEMENT AND PROVIDERS (1500–2000 words)
   - State management comparison table:
     Provider vs. BLoC vs. Riverpod vs. GetX — why Provider was chosen
   - Provider architecture:
     * ChangeNotifier base class explanation
     * notifyListeners() mechanism
     * Consumer and context.read/watch patterns
     * MultiProvider setup at app root
   - Include a Mermaid diagram of the provider tree structure
   - Provider descriptions table — for each provider:
     | Provider | Responsibility | Key State Variables | Key Methods | API Calls |
   - Data flow with Mermaid sequence diagram:
     UI Action → Provider Method → API Service → Backend → Response →
     State Update → UI Rebuild
     (Use "Load home dashboard" as example flow)
   - Error handling in providers:
     * Loading states (isLoading flag)
     * Error states (errorMessage)
     * UI feedback (SnackBar, error widgets)
   - Include code snippets showing provider patterns

3. UI/UX DESIGN AND DISCUSSION (1500–2000 words)
   - Design philosophy:
     * Safety-first: emergency visibility over aesthetics
     * Dark theme justification (reduces eye strain, makes red alerts stand out)
     * Color psychology: red for danger, green for safe, amber for warning
     * Minimal interaction during emergencies (large touch targets)
   - Color palette table:
     | Color Name | Hex Code | Usage |
   - Screen-by-screen walkthrough — for EACH screen describe:
     * Purpose and user goal
     * Key UI elements
     * User interactions
     * Navigation connections
     * Figure placeholder: "Figure X.Y: [ScreenName] screen — [insert screenshot]"
     Cover ALL screens: Splash, Login, Signup, ForgotPassword, Home,
     Cameras, Alert, Notification, Settings
   - Emergency UX design:
     * Full-screen alert rationale (cannot be dismissed accidentally)
     * Multi-sensory feedback: visual (pulsing red) + audio (siren) + haptic (vibration)
     * Action buttons: "Mark Resolved" and "False Alarm"
     * Event info: camera name, zone, event type, confidence, timestamp
     * Suggest infographic: "Emergency alert UX multi-sensory feedback model"
   - Responsive design:
     * flutter_screenutil configuration and usage
     * Layout adaptation across screen sizes
     * Font scaling and spacing calculations

4. NAVIGATION ARCHITECTURE (800–1000 words)
   - go_router route definitions
   - Named routes and path parameters
   - Auth-guarded routes (redirect to login if unauthenticated)
   - Include a Mermaid diagram of the complete navigation graph
   - Deep linking from push notifications to alert screen

5. ACCESSIBILITY AND PLATFORM CONSIDERATIONS (500–800 words)
   - Color contrast ratios
   - Touch target sizes (minimum 48×48 dp)
   - Screen reader compatibility (semantic widgets)
   - Android vs. iOS platform differences
   - Push notification handling: foreground, background, app killed states

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Section headings: 14 pt bold
- Chapter title: 16 pt bold
- Line spacing: 1.5
- Text alignment: justified
- All figures must have captions: "Figure X.Y: [Description]"
- All tables must have captions: "Table X.Y: [Description]"
- Suggest page breaks between major sections
- Number all sections hierarchically (e.g., 7.1, 7.1.1, 7.1.2)

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Include a REFERENCES section at the end of this chapter with:
  * Real Flutter documentation references (flutter.dev)
  * Real Dart documentation references
  * Real Provider package documentation
  * Real Firebase Flutter plugin documentation
  * Real UI/UX design references (Nielsen Norman Group, Material Design guidelines)
  * Real mobile accessibility references (WCAG)
  * Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.
  * Minimum 12 references for this chapter

DIAGRAMS AND VISUALS:
- Include Mermaid diagrams wherever specified
- Include tables wherever specified
- Include figure placeholders for ALL screens
- Include code snippets where specified

TOKEN OPTIMIZATION:
- Target output: approximately 15–25 Word pages
- If the chapter is too long for a single generation, indicate clearly where
  to split and provide a continuation prompt
```

</details>

---

<br/>

---

# 4 — 💾 Database Team Chapter

<details>
<summary><b>Click to expand full prompt (~15–25 pages output)</b></summary>

```
You are an expert academic engineering writer specializing in database design,
data modeling, and ORM systems. You are writing a chapter for a graduation project
report/book submitted to a university engineering faculty.

Write the COMPLETE DATABASE DESIGN CHAPTER for the following project.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM OVERVIEW (for context only — focus this chapter on the database):
- Microservice architecture: FastAPI AI Service + Django Backend + Flutter Mobile App
- Database: SQLite3 ONLY (zero-configuration, file-based, NO PostgreSQL, NO MySQL)
- Push notifications: Firebase Cloud Messaging (FCM)
- Camera: External WiFi camera connected through USB and used as webcam input
  during live demo/testing
- Containerization: Docker + Docker Compose
- ORM: Django ORM (models define schema, migrations manage schema evolution)
- Database file location: backend/db.sqlite3 (inside backend container)

IMPORTANT: This project uses SQLite3 exclusively. There is NO PostgreSQL and NO MySQL
anywhere in the system. Do NOT mention PostgreSQL or MySQL as being used in this
project. You may only mention them in comparison tables for justification purposes.

DATABASE ENTITIES AND MODELS:

1. User (Django built-in auth_user table):
   - id (INTEGER, PK, auto-increment)
   - username (VARCHAR(150), UNIQUE, NOT NULL)
   - email (VARCHAR(254))
   - password (VARCHAR(128), hashed PBKDF2+SHA256)
   - first_name (VARCHAR(150))
   - last_name (VARCHAR(150))
   - is_staff (BOOLEAN)
   - is_active (BOOLEAN)
   - date_joined (DATETIME)

2. UserProfile (accounts app):
   - id (INTEGER, PK)
   - user (OneToOneField → auth.User, CASCADE)
   - phone (VARCHAR, nullable)
   - avatar (ImageField, nullable)

3. Zone (cameras app):
   - id (INTEGER, PK)
   - name (VARCHAR, NOT NULL)
   - description (TEXT, nullable)
   - created_at (DATETIME, auto)

4. Camera (cameras app):
   - id (INTEGER, PK)
   - name (VARCHAR, NOT NULL)
   - location (VARCHAR)
   - stream_url (URLField)
   - thumbnail (ImageField, nullable)
   - status (VARCHAR — choices: online/offline)
   - zone (ForeignKey → Zone, CASCADE)
   - created_at (DATETIME, auto)

5. FireEvent (events app):
   - id (INTEGER, PK)
   - event_type (VARCHAR — choices: fire/smoke)
   - status (VARCHAR — choices: active/resolved/false_alarm)
   - ai_confidence (FLOAT)
   - snapshot (ImageField, nullable)
   - notes (TEXT, nullable)
   - detected_at (DATETIME, auto)
   - resolved_at (DATETIME, nullable)
   - camera (ForeignKey → Camera, CASCADE)

6. FCMDevice (notifications app):
   - id (INTEGER, PK)
   - user (ForeignKey → auth.User, CASCADE)
   - token (VARCHAR, UNIQUE)
   - platform (VARCHAR — choices: android/ios)
   - is_active (BOOLEAN, default True)
   - created_at (DATETIME, auto)

7. NotificationPreference (notifications app):
   - id (INTEGER, PK)
   - user (OneToOneField → auth.User, CASCADE)
   - fire_alerts (BOOLEAN, default True)
   - resolved_alerts (BOOLEAN, default True)
   - false_alarm_alerts (BOOLEAN, default True)
   - sound_enabled (BOOLEAN, default True)

RELATIONSHIPS:
- User 1:1 UserProfile (auto-created via Django signal)
- User 1:1 NotificationPreference
- User 1:N FCMDevice (one user, multiple devices)
- Zone 1:N Camera (one zone, multiple cameras)
- Camera 1:N FireEvent (one camera, multiple events)

══════════════════════════════════════════════════════════
CHAPTER STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

1. CHAPTER INTRODUCTION (500–800 words)
   - Role of the database in the FireGuard system
   - Why a relational database approach was chosen
   - Overview of Django ORM as the data access layer
   - Chapter roadmap

2. DATABASE ENGINE SELECTION (1000–1500 words)
   - Why SQLite3 was chosen for this project
   - Advantages: zero configuration, file-based, no separate server process,
     built into Python, ACID-compliant, perfect for single-server deployments
   - Limitations: single writer at a time, no concurrent write scaling,
     no network access (local file only)
   - Why limitations are acceptable for this project's scale
     (single backend instance, low concurrent write volume, graduation demo)
   - Comparison table: SQLite3 vs. PostgreSQL vs. MySQL
     | Feature | SQLite3 | PostgreSQL | MySQL |
     (configuration, server requirement, concurrent writes, max DB size,
      ACID compliance, deployment complexity, use case fit)
   - SQLite3 in the Django ecosystem: built-in support, no additional packages
   - Include code snippet from settings.py showing DATABASES configuration

3. ENTITY-RELATIONSHIP DIAGRAM (1500–2000 words)
   - Complete Mermaid erDiagram showing ALL 7 entities with:
     * All columns and data types
     * Cardinality (1:1, 1:N)
     * Primary keys (PK) and foreign keys (FK)
   - Entity descriptions — for EACH entity provide:
     * Purpose in the system
     * Key attributes and their data types
     * Business rules and constraints
     * Relationships in natural language
     Present as a structured table per entity
   - Relationship analysis — explain each relationship with examples:
     * "A User has exactly one UserProfile" (1:1, auto-created via Django signal)
     * "A Zone contains zero or more Cameras" (1:N)
     * "A Camera triggers zero or more FireEvents" (1:N)
     * "A User owns zero or more FCMDevices" (1:N)
     * "A User has exactly one NotificationPreference" (1:1)
   - Referential integrity: CASCADE vs. SET_NULL on delete — explain choices
   - Relationship matrix table:
     | Entity A | Entity B | Cardinality | On Delete | Description |

4. DATABASE SCHEMA DETAIL (1500–2000 words)
   - For EACH table, provide a complete schema table:
     | Column | Type | Constraints | Default | Description |
   - Include Django model code snippets for each model
   - Discuss field choices:
     * CharField vs. TextField decisions
     * ImageField storage configuration
     * DateTimeField auto_now vs. auto_now_add
     * Choices fields (status, event_type, platform)
   - Indexes: Django auto-creates indexes on ForeignKey and unique fields
   - Django built-in tables used: auth_user, authtoken_token, django_session

5. DJANGO ORM AND MIGRATIONS (1000–1500 words)
   - How Django ORM maps Python classes to SQL tables
   - Migration system: makemigrations → migrate workflow
   - Migration files and version control
   - Docker startup: migrate --noinput in entrypoint.sh
   - Common Django ORM query patterns with code examples:
     * List active events: FireEvent.objects.filter(status='active')
     * Count by type: FireEvent.objects.values('event_type').annotate(count=Count('id'))
     * Filter by camera: FireEvent.objects.filter(camera__zone__name='Zone A')
     * Get user with profile: User.objects.select_related('userprofile')
   - Query optimization: select_related, prefetch_related
   - SQLite3-specific considerations:
     * WAL mode for better read concurrency
     * No connection pooling needed (file-based)
     * JSON field limitations (not natively supported until SQLite 3.38)

6. NORMALIZATION AND DATA INTEGRITY (800–1000 words)
   - Schema normalization analysis (3NF compliance)
   - Identify any denormalization decisions and justification
   - Data integrity mechanisms:
     * Django model validation (clean methods, validators)
     * Database-level constraints (NOT NULL, UNIQUE, FK)
     * Application-level validation (DRF serializers)
   - Data lifecycle: event creation → status transitions → resolution

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Section headings: 14 pt bold
- Chapter title: 16 pt bold
- Line spacing: 1.5
- Text alignment: justified
- All figures must have captions: "Figure X.Y: [Description]"
- All tables must have captions: "Table X.Y: [Description]"
- Suggest page breaks between major sections
- Number all sections hierarchically (e.g., 8.1, 8.1.1, 8.1.2)

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Include a REFERENCES section at the end of this chapter with:
  * Real SQLite documentation references (sqlite.org)
  * Real Django ORM documentation references (djangoproject.com)
  * Real database design textbooks (e.g., Elmasri & Navathe, Date)
  * Real normalization theory references
  * Real ER modeling references (Chen 1976)
  * Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.
  * Minimum 10 references for this chapter

DIAGRAMS AND VISUALS:
- Include complete Mermaid erDiagram
- Include tables wherever specified
- Include Django model code snippets
- Include figure placeholders where applicable

TOKEN OPTIMIZATION:
- Target output: approximately 15–20 Word pages
- If the chapter is too long for a single generation, indicate clearly where
  to split and provide a continuation prompt
```

</details>

---

<br/>

---

# 5 — 🐳 Deployment Team Chapter

<details>
<summary><b>Click to expand full prompt (~15–25 pages output)</b></summary>

```
You are an expert academic engineering writer specializing in DevOps, containerization,
deployment, software testing, and project evaluation. You are writing a chapter for a
graduation project report/book submitted to a university engineering faculty.

Write the COMPLETE DEPLOYMENT, TESTING, AND EVALUATION CHAPTER for the following project.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM OVERVIEW:
- Microservice architecture: FastAPI AI Service + Django Backend + Flutter Mobile App
- Database: SQLite3 ONLY (zero-configuration, file-based, no PostgreSQL)
- Push notifications: Firebase Cloud Messaging (FCM)
- Camera: External WiFi camera connected through USB and used as webcam input
  during live demo/testing
- Containerization: Docker + Docker Compose

DOCKER CONFIGURATION:
- docker-compose.yml (version: "3.10") with 2 application services:
  * ai_service: python:3.10-slim + OpenCV native libs (libgl1, libglib2.0-0, libsm6,
    libxext6, libxrender1, libxcb1) + pip requirements + CMD uvicorn main:app
    --host 0.0.0.0 --port 8001
  * backend: python:3.10-slim + pip requirements + sed CRLF fix +
    ENTRYPOINT entrypoint.sh
- Network: app_network (bridge driver, container DNS resolution)
- Health checks: python urllib.request.urlopen for ai_service and backend
- depends_on with health check conditions
- Environment variables passed via docker-compose.yml

BACKEND DEPLOYMENT:
- Gunicorn 21.2: --bind 0.0.0.0:8000 --workers 3
- entrypoint.sh workflow:
  * set -e (exit on error)
  * python manage.py migrate --noinput
  * python manage.py collectstatic --noinput || true
  * exec gunicorn fireguard.wsgi:application --bind 0.0.0.0:8000 --workers 3
- Procfile: web: gunicorn fireguard.wsgi (for PythonAnywhere/Heroku)
- PythonAnywhere as alternative cloud host

AI SERVICE DEPLOYMENT:
- FastAPI 0.110+ served by Uvicorn (ASGI, single worker)
- Endpoints: GET / (health), GET /status, GET /cameras, POST /predict
- Model loaded at import time, warmup inference on startup
- Single worker for model thread safety

TESTING CONTEXT:
- AI model evaluation: mAP, precision, recall, F1, confusion matrix
- API testing: manual with curl/Postman, health check endpoints
- Mobile testing: physical Android devices
- Integration testing: end-to-end detection → notification flow
- Live demo: USB camera → AI detection → push notification → mobile alert

══════════════════════════════════════════════════════════
CHAPTER STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

1. DEPLOYMENT CHAPTER INTRODUCTION (600–800 words)
   - Deployment strategy overview: local dev, Docker-based, cloud (PythonAnywhere)
   - Mobile app distribution (APK build for Android)
   - Deployment comparison table:
     | Method | Environment | Pros | Cons | Use Case |
   - Include Mermaid diagram: Docker Compose topology showing services,
     ports, networks, external connections (Firebase, mobile, camera)
   - Chapter roadmap

2. DOCKER ARCHITECTURE (1500–2000 words)
   - Docker and containerization overview
   - Comparison table: Containers vs. VMs
   - Dockerfile analysis — for EACH Dockerfile, line-by-line explanation:
     * Base image: python:3.10-slim justification
     * System dependencies (AI service: OpenCV native libs)
     * Requirements installation (layer caching)
     * Code copy strategy
     * Entrypoint vs. CMD
     Include annotated Dockerfile code blocks
   - Docker Compose configuration — annotated docker-compose.yml:
     * Service definitions and relationships
     * depends_on with health check conditions
     * Port mapping (8000, 8001)
     * Environment variables
     * Network (bridge driver, DNS)
   - Build and run workflow: docker compose up --build
   - Include Mermaid startup sequence diagram:
     ai_service starts → health check passes → backend starts → migrate → gunicorn
   - Health check strategy table:
     | Service | Method | Interval | Timeout | Retries |

3. FASTAPI / UVICORN DEPLOYMENT (1000–1200 words)
   - FastAPI overview: modern, async-first, Starlette + Pydantic,
     auto OpenAPI/Swagger docs
   - Comparison table: FastAPI vs. Flask vs. Django for AI serving
   - Uvicorn ASGI server: ASGI vs. WSGI comparison
   - Single-worker config for model thread safety
   - Endpoint architecture table:
     | Endpoint | Method | Purpose | Input | Output |
   - Model lifecycle: load once at import, warmup, thread safety
   - Deployment commands (Docker CMD and local dev)

4. GUNICORN DEPLOYMENT (800–1000 words)
   - Gunicorn overview: pre-fork worker model
   - Comparison table: Django runserver vs. Gunicorn
   - Worker configuration: 3 workers (2×CPU + 1), sync type
   - entrypoint.sh annotated walkthrough:
     * set -e, migrate, collectstatic, exec gunicorn
     * exec replaces shell (PID 1 signal forwarding for Docker)
   - Production considerations: static files, timeouts, logging

5. TESTING AND VALIDATION (2000–2500 words)
   - Testing strategy overview and matrix:
     | Test Type | Scope | Tool | Status |
   - AI model validation:
     * Metrics: Precision, Recall, F1, mAP@0.5, mAP@0.5:0.95
     * Results tables with placeholder metrics [X]
     * Confusion matrix analysis
     * Figure placeholders: PR curve, confusion matrix, sample detections
   - API testing:
     * Endpoint testing methodology (curl/Postman)
     * Test case table: Test ID | Endpoint | Input | Expected | Result
   - Mobile app testing:
     * Physical device testing, screen verification
     * Push notification testing (foreground, background, killed)
     * Emergency UX testing (siren, vibration, full-screen)
   - Integration testing:
     * End-to-end flow: camera → AI → backend → Firebase → mobile
     * Include Mermaid integration test flow diagram
   - Live demo testing:
     * USB camera setup, fire/smoke simulation
     * Response time measurement, false positive analysis
     * Demo results table

6. RESULTS AND PERFORMANCE ANALYSIS (2000–2500 words)
   - AI model performance tables:
     * Overall: mAP@0.5, mAP@0.5:0.95, precision, recall (placeholder [X])
     * Per-class: fire P/R/F1, smoke P/R/F1
     * Inference speed: FPS, ms/frame, hardware specs
   - Figure placeholders (minimum 6):
     PR curve, F1-confidence curve, confusion matrix, training loss curves,
     mAP progression, sample detection results
   - System performance — end-to-end latency table:
     | Stage | Latency (ms) |
     (frame capture, network transfer, AI inference, backend processing,
      FCM delivery, total)
   - Notification delivery performance
   - Mobile app performance (startup, transitions, memory)
   - Comparative analysis table: FireGuard vs. [Paper 1] vs. [Paper 2]
   - Discussion: objectives achievement, limitations, threats to validity
   - Suggest infographic: "End-to-end pipeline performance waterfall"

7. CHALLENGES AND PROBLEMS FACED (1000–1500 words)
   - Technical challenges:
     * YOLOv8 training on limited GPU
     * OpenCV native libs in Docker
     * Windows CRLF breaking entrypoint.sh in Linux containers
     * SQLite concurrent write limitations with Gunicorn workers
     * Firebase init failures, camera driver compatibility
     * Docker image size (OpenCV + PyTorch)
   - Integration challenges:
     * Docker service synchronization (health checks)
     * Flutter FCM token lifecycle
     * CORS configuration
   - For each challenge: Problem | Impact | Solution | Lesson Learned
   - Key lessons learned summary

8. FUTURE WORK (1000–1500 words)
   - AI: multi-class detection, model quantization (INT8/FP16), ONNX/TensorRT,
     temporal analysis, severity estimation
   - Backend: WebSocket dashboard (Django Channels), rate limiting, RBAC,
     analytics dashboard, PostgreSQL migration for production
   - Mobile: live camera streaming, offline mode, multi-language,
     App Store/Play Store distribution
   - Infrastructure: Kubernetes, CI/CD (GitHub Actions), monitoring
     (Prometheus/Grafana), HTTPS/SSL
   - Hardware: RTSP IP cameras, edge AI (Jetson/Coral), IoT sensor fusion
   - Future work roadmap table:
     | Category | Improvement | Priority | Effort | Impact |
   - Include Mermaid roadmap diagram: short-term vs. medium-term vs. long-term

9. CONCLUSION (800–1000 words)
   - Project summary (restate problem, summarize solution)
   - Objectives achievement table:
     | Objective | Status (Achieved/Partial/Not Achieved) | Evidence |
   - Key contributions (3–5 items)
   - Limitations (honest assessment)
   - Final remarks: significance, real-world impact, AI in public safety

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Section headings: 14 pt bold
- Chapter title: 16 pt bold
- Line spacing: 1.5
- Text alignment: justified
- All figures must have captions: "Figure X.Y: [Description]"
- All tables must have captions: "Table X.Y: [Description]"
- Suggest page breaks between major sections
- Number all sections hierarchically (e.g., 9.1, 9.1.1, 9.1.2)

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Include a REFERENCES section at the end of this chapter with:
  * Real Docker documentation references (docs.docker.com)
  * Real FastAPI documentation references (fastapi.tiangolo.com)
  * Real Gunicorn documentation references (gunicorn.org)
  * Real software testing references (IEEE 829, ISTQB)
  * Real DevOps and CI/CD references
  * Real containerization research papers
  * Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.
  * Minimum 15 references for this chapter

DIAGRAMS AND VISUALS:
- Include Mermaid diagrams wherever specified
- Include tables wherever specified
- Include annotated code blocks for Dockerfiles and scripts
- Include figure placeholders for performance charts
- Suggest infographics where applicable

TOKEN OPTIMIZATION:
- Target output: approximately 20–25 Word pages
- This is the largest chapter — if too long for a single generation,
  split at section 5 (Testing) and provide a continuation prompt:
  "Continue from section 5: Testing and Validation..."
```

</details>

---

<br/>

---

<div align="center">

## 📌 Tips for Using These Prompts

| Tip | Description |
|:---|:---|
| 🎯 **Replace Placeholders** | Replace all `[X]` with your actual data before submitting |
| 📐 **Adapt Length** | Adjust word counts based on your university's requirements |
| 🔗 **Cross-Reference** | After generating all chapters, ensure they reference each other consistently |
| 📸 **Screenshots** | Replace figure placeholders with actual app screenshots and diagrams |
| 📖 **Verify Citations** | **Every single reference must be verified** — never submit unchecked AI citations |
| 🔄 **Iterate** | Ask Claude to revise, expand, or restructure sections after first output |
| 📄 **Word Export** | Copy output to Word, apply Times New Roman / 1.5 spacing / justified alignment |
| 🗣️ **Your Voice** | Always add your personal observations and project-specific technical details |
| ⚠️ **Token Limits** | If Claude truncates output, say: "Continue from section X..." |
| 🔢 **Chapter Numbers** | Adjust section numbering (e.g., 5.1, 6.1) to match your report's chapter order |

---

### 📊 Output Size Estimates

| Prompt | Estimated Pages | Estimated Word Count | References |
|:-------|:----------------|:---------------------|:-----------|
| AI Team | 18–25 pages | 8,000–12,000 words | 15+ refs |
| Backend Team | 15–22 pages | 6,500–9,000 words | 12+ refs |
| Frontend/UI Team | 15–20 pages | 6,000–8,500 words | 12+ refs |
| Database Team | 12–18 pages | 5,000–7,000 words | 10+ refs |
| Deployment Team | 20–25 pages | 9,000–13,000 words | 15+ refs |
| **Total** | **80–110 pages** | **34,500–49,500 words** | **64+ refs** |

---

*Generated for the FireGuard Graduation Project — May 2026*

</div>
