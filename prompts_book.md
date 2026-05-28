<div align="center">

# 🔥 FireGuard — Graduation Project Book Master Prompts

### AI-Powered Fire & Smoke Detection and Emergency Alert System

---

**10 Master Prompts for Claude Sonnet 4.6**

Each prompt generates one complete chapter for the graduation project book.
All prompts are derived from the official repository documentation and source code.
Optimized for IEEE citations · Word-ready formatting · Implementation-aligned content.

---

</div>

<br/>

## 📌 How to Use This File

| Step | Action |
|:-----|:-------|
| 1 | Copy the **entire prompt** from a chapter section below |
| 2 | Paste it into a new Claude Sonnet 4.6 conversation on the Anthropic platform |
| 3 | Replace all `[X]` placeholders with your real project data (dataset stats, metric values, screenshots) |
| 4 | Review the output, then ask Claude to revise or expand sections as needed |
| 5 | Export to Word, apply the specified formatting, insert real screenshots and diagrams |
| 6 | **Verify every citation** — never submit AI-generated references without checking |

> ⚠️ **Important**: These are **prompts**, not the final book content. Each prompt is designed to generate ~8–15 pages of structured academic content when submitted to Claude Sonnet 4.6.

---

## 📋 Table of Contents

| # | Chapter Prompt | Chapter # | Approx. Pages | Key Topics |
|:--|:--------------|:----------|:--------------|:-----------|
| 1 | [Introduction](#1--introduction-chapter) | Chapter 1 | 8–10 | Problem statement, objectives, scope, project overview |
| 2 | [Literature Review](#2--literature-review) | Chapter 2 | 10–15 | Fire detection research, YOLO evolution, related work |
| 3 | [System Analysis & Design](#3--system-analysis-and-design) | Chapter 3 | 10–12 | Requirements, UML, DFD, architecture |
| 4 | [AI Development](#4--ai-development-chapter) | Chapter 4 | 12–15 | Dataset, YOLOv8, PyTorch, inference pipeline, OpenCV |
| 5 | [Backend Development](#5--backend-development-chapter) | Chapter 5 | 10–12 | Django, DRF, APIs, Firebase integration |
| 6 | [Mobile Application & UI/UX](#6--mobile-application--uiux-chapter) | Chapter 6 | 10–12 | Flutter, Provider, screens, emergency UX |
| 7 | [Database Design](#7--database-design-chapter) | Chapter 7 | 8–10 | SQLite3, schema, ERD, Django ORM |
| 8 | [Deployment & Integration](#8--deployment--integration-chapter) | Chapter 8 | 6–8 | PythonAnywhere, component integration, environment |
| 9 | [Testing & Results](#9--testing--results-chapter) | Chapter 9 | 8–10 | Manual testing, live demo, results analysis |
| 10 | [Conclusion & Future Work](#10--conclusion--future-work-chapter) | Chapter 10 | 5–7 | Summary, achievements, limitations, future directions |

**Total estimated book length: ~87–111 pages**

---

## 🔒 Terminology Consistency Rules (ALL PROMPTS)

Every prompt below embeds the following mandatory terminology. Claude MUST use these terms consistently across all generated chapters:

| Term | Definition |
|------|-----------|
| **FireEvent** | The core data entity representing a single fire or smoke detection incident, stored in `events_fireevent` table |
| **AI Camera Node** / **Edge Node** | The local machine running `camera.py` with YOLOv8, performing inference at the edge |
| **Detection Event** | The real-time occurrence of YOLOv8 identifying fire or smoke in a frame with confidence ≥ 50% |
| **Confidence Threshold** | The minimum confidence score (0.5 / 50%) required for YOLOv8 to report a detection |
| **Active Event** | A FireEvent with `status = 'active'` — not yet reviewed or resolved |
| **Notification Payload** | The structured data package sent via FCM containing `notification` and `data` objects |
| **Inference Pipeline** | The complete processing chain from raw camera frame to detection result |
| **Cooldown** | A 10-second suppression interval between consecutive alerts in `camera.py` |
| **Snapshot** | An annotated JPEG image captured at the moment of detection, with bounding boxes drawn by `r.plot()` |
| **AlertPayload** | The Dart class in the Flutter app that maps FCM `data` payload to a structured object |

---

## 🏗️ Real Architecture Reference (ALL PROMPTS)

All prompts must describe only the following real architecture:

```
AI Service (camera.py + YOLOv8 + OpenCV)
    → HTTP POST /api/events/
Django Backend (Django 5.2 + DRF 3.17)
    → SQLite3 (db.sqlite3)
    → Firebase Admin SDK → Firebase Cloud Messaging
        → Flutter Mobile App (Flutter 3.9 + Provider + Dio)
```

**Deployment:** PythonAnywhere (backend), Local machine (AI service), Android device (Flutter app)

**There is NO:** FastAPI, Docker, Docker Compose, Kubernetes, PostgreSQL, Redis, MySQL, Gunicorn (except in PythonAnywhere WSGI), microservices architecture, CI/CD pipeline, or cloud-native infrastructure.

---

## 👥 Team Responsibility Mapping

| Area | Team Members |
|------|-------------|
| AI Development | Ali Khaled Abo Raya, Mohamed Abdelfatah Attalah, Mohamed Asaad |
| Backend Development | Abdelrahman Reda Abdellah |
| Mobile Application & UI/UX | Mohamed Hany El-Essawy, Saad Ezzat Saad |
| Database Development | Tarek Mostafa Kashef |
| Deployment & Integration | Mostafa Abdo El-Gohary |

---

<br/>

---

# 1 — 📖 Introduction Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 1: ~8–10 pages)</b></summary>

```
You are a senior academic engineering writer with expertise in computer vision,
software engineering, and technical documentation. You are writing the INTRODUCTION
CHAPTER (Chapter 1) for a graduation project book submitted to a university
engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

PROJECT OVERVIEW:
FireGuard is a graduation project that implements an AI-powered fire and smoke
detection system with real-time mobile notifications. The system combines computer
vision inference at the edge with a centralized backend and a cross-platform
mobile application to provide end-to-end fire safety monitoring.

REAL ARCHITECTURE (use ONLY this — do NOT invent additional components):
- AI Service: Standalone Python script (camera.py) running on a local machine
  with a webcam. Uses YOLOv8 (Ultralytics) for fire/smoke detection and OpenCV
  for frame capture. Reports detections via HTTP POST to the Django backend.
- Backend: Django 5.2 + Django REST Framework 3.17. SQLite3 database.
  Firebase Admin SDK for push notification dispatch.
- Mobile App: Flutter 3.9 with Provider state management. Receives FCM
  push notifications. Uses Dio for HTTP communication with the backend.
- Database: SQLite3 ONLY (file-based, managed by Django ORM).
- Notifications: Firebase Cloud Messaging (FCM).
- Deployment: Backend on PythonAnywhere. AI service runs locally.

REAL WORKFLOW:
Camera → OpenCV frame capture → YOLOv8 inference (conf ≥ 0.5) → Cooldown check
→ Save annotated snapshot → POST /api/events/ → Django creates FireEvent in SQLite3
→ Firebase Admin SDK sends FCM multicast → Flutter app receives notification
→ Alert screen displayed → User resolves or marks as false alarm.

TEAM MEMBERS:
- AI Development: Ali Khaled Abo Raya, Mohamed Abdelfatah Attalah, Mohamed Asaad
- Backend Development: Abdelrahman Reda Abdellah
- Mobile Application & UI/UX: Mohamed Hany El-Essawy, Saad Ezzat Saad
- Database Development: Tarek Mostafa Kashef
- Deployment & Integration: Mostafa Abdo El-Gohary

TERMINOLOGY (use these terms consistently throughout):
- FireEvent, AI Camera Node, Detection Event, Confidence Threshold,
  Active Event, Notification Payload, Edge Node, Inference Pipeline,
  Cooldown, Snapshot, AlertPayload

══════════════════════════════════════════════════════════
CHAPTER 1 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Introduce the reader to the FireGuard project by establishing the problem domain
(fire hazards, limitations of traditional detection), presenting the proposed
AI-based solution, defining project objectives and scope, and providing an
overview of the system architecture and the graduation book structure.

1.1 BACKGROUND AND MOTIVATION (600–800 words)
   - The global impact of fire hazards on life, property, and industry
   - Statistics on fire-related incidents (use real, citable statistics from
     NFPA, WHO, or national fire safety organizations)
   - Traditional fire detection systems: smoke detectors, heat sensors, sprinklers
   - Limitations of traditional systems: limited spatial coverage, delayed
     triggering, high false-alarm rates, no visual verification
   - The rise of computer vision and deep learning as complementary detection methods
   - Motivation for building FireGuard as a graduation project

1.2 PROBLEM STATEMENT (300–400 words)
   - Clearly define the problem being solved
   - Emphasize: existing systems cannot provide visual verification,
     real-time mobile alerts, or AI-confidence-based event management
   - State the gap that FireGuard addresses

1.3 PROJECT OBJECTIVES (300–400 words)
   - List 5–7 specific, measurable objectives:
     1. Develop a real-time fire and smoke detection system using YOLOv8
     2. Build a Django REST API backend for event management and notification dispatch
     3. Implement a Flutter mobile application for real-time alerts and event management
     4. Integrate Firebase Cloud Messaging for instant push notifications
     5. Design and implement a relational database schema using SQLite3
     6. Deploy and integrate all system components into a functioning prototype
     7. Validate the system through manual testing and live demonstration
   - Each objective should be linked to a specific chapter

1.4 PROJECT SCOPE (400–500 words)
   - Explicitly define what IS included in the project:
     * Real-time fire/smoke detection from a single webcam
     * Event storage with status lifecycle (active → resolved / false_alarm)
     * Push notifications via FCM
     * Mobile app with alert and management UI
     * Camera and zone management
     * User authentication and profile management
     * Notification preferences (per-user opt-in/opt-out)
   - Explicitly state what is NOT included (and note "Not implemented in the
     current project version"):
     * Multi-camera concurrent processing
     * Web-based admin dashboard
     * Video clip recording
     * CI/CD pipeline
     * PostgreSQL or other production databases
     * Role-based access control beyond admin/user
   - Include a Table: "Table 1.1: Project Scope Summary"
     with columns: Capability | Status (✅ Implemented / ❌ Not Implemented)

1.5 PROPOSED SOLUTION OVERVIEW (500–700 words)
   - Three-component architecture overview:
     1. AI Camera Node (Edge): camera.py + YOLOv8 + OpenCV
     2. Backend Tier: Django 5.2 + DRF 3.17 + SQLite3 + Firebase Admin SDK
     3. Client Tier: Flutter 3.9 mobile app + FCM + local SQLite
   - Include a Mermaid architecture diagram showing all three tiers
   - Include a Mermaid sequence diagram showing the end-to-end detection workflow
   - Technology stack table: "Table 1.2: Technology Stack"
     | Layer | Technology | Version | Purpose |
   - Briefly describe the data flow from camera to mobile alert

1.6 BOOK STRUCTURE (300–400 words)
   - Provide a chapter-by-chapter overview of the graduation book:
     * Chapter 1: Introduction (this chapter)
     * Chapter 2: Literature Review
     * Chapter 3: System Analysis and Design
     * Chapter 4: AI Development
     * Chapter 5: Backend Development
     * Chapter 6: Mobile Application & UI/UX
     * Chapter 7: Database Design
     * Chapter 8: Deployment & Integration
     * Chapter 9: Testing & Results
     * Chapter 10: Conclusion & Future Work
   - Each chapter description should be 2–3 sentences

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Chapter title: 16 pt bold ("Chapter 1: Introduction")
- Main section headings (1.1, 1.2, etc.): 14 pt bold
- Subsection headings (1.1.1, etc.): 13 pt bold
- Line spacing: 1.5
- Text alignment: Justified
- Standard A4 page size
- All figures must have captions: "Figure 1.Y: [Description]"
- All tables must have captions: "Table 1.Y: [Description]"
- Suggest page breaks between major sections

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim and statistic must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Do NOT use fake DOIs or broken URLs

REFERENCES (minimum 8 references):
- Real fire safety statistics (NFPA, WHO)
- Real computer vision references (YOLO papers, OpenCV)
- Real software engineering references
- Official framework documentation (Django, Flutter, Firebase)
- IEEE or Springer published papers on fire detection systems
- Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.

End the chapter with:
## References
(formatted in IEEE style)

DIAGRAMS AND VISUALS:
- Include Mermaid diagrams wherever specified
- Include tables wherever specified
- Include figure placeholders: "Figure 1.Y: [Description] — [insert screenshot/diagram]"

TOKEN OPTIMIZATION:
- Target output: approximately 8–10 Word pages
- If output must be split, clearly indicate the split point and provide
  a continuation prompt
```

</details>

---

<br/>

---

# 2 — 📚 Literature Review

<details>
<summary><b>Click to expand full prompt (Chapter 2: ~10–15 pages)</b></summary>

```
You are a senior academic engineering writer with expertise in computer vision,
deep learning, object detection, and software engineering. You are writing the
LITERATURE REVIEW CHAPTER (Chapter 2) for a graduation project book submitted
to a university engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

PROJECT CONTEXT (for reference only — this chapter reviews existing literature):
FireGuard uses YOLOv8 (Ultralytics) for real-time fire and smoke detection from
a webcam feed. The AI service (camera.py) runs locally as an Edge Node, posting
detection events to a Django 5.2 backend with SQLite3. Firebase Cloud Messaging
delivers push notifications to a Flutter 3.9 mobile app.

TERMINOLOGY (use consistently):
- FireEvent, AI Camera Node, Detection Event, Confidence Threshold,
  Active Event, Notification Payload, Edge Node, Inference Pipeline

══════════════════════════════════════════════════════════
CHAPTER 2 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Review existing literature and research related to fire detection systems,
object detection algorithms, and the technologies used in FireGuard. Establish
the theoretical foundation for the project's design decisions.

2.1 INTRODUCTION TO FIRE DETECTION SYSTEMS (600–800 words)
   - Evolution of fire detection: from manual observation to sensor-based
     to vision-based systems
   - Categories: point-type sensors, aspirating systems, video-based systems
   - Advantages and limitations of each category
   - Include Table: "Table 2.1: Comparison of Fire Detection Approaches"
     | Approach | Detection Method | Response Time | Coverage | False Alarm Rate | Visual Evidence |

2.2 TRADITIONAL FIRE DETECTION METHODS (500–700 words)
   - Smoke detectors: ionization vs. photoelectric
   - Heat detectors: fixed-temperature vs. rate-of-rise
   - Flame detectors: UV, IR, UV/IR combined
   - Multi-sensor systems
   - Limitations in real-world deployment
   - Reference real IEEE/Springer papers on sensor-based fire detection

2.3 VISION-BASED FIRE DETECTION (800–1000 words)
   - Color-based methods (RGB, HSV, YCbCr color space analysis)
   - Motion-based methods (optical flow, background subtraction)
   - Texture-based methods (wavelet analysis)
   - Deep learning-based methods (CNN, R-CNN, SSD, YOLO)
   - Comparison table: "Table 2.2: Vision-Based Fire Detection Methods"
     | Method | Technique | Accuracy | Real-Time? | Limitations |
   - Reference at least 5 real published papers on vision-based fire detection

2.4 OBJECT DETECTION ALGORITHMS (1000–1500 words)
   - Two-stage detectors: R-CNN → Fast R-CNN → Faster R-CNN
   - Single-stage detectors: SSD, YOLO family, RetinaNet
   - Transformer-based: DETR
   - Evolution of YOLO: YOLOv1 through YOLOv8
     * YOLOv1 (Redmon et al., 2016): unified detection, grid-based
     * YOLOv2/v3: multi-scale, feature pyramids, anchor boxes
     * YOLOv4/v5: CSPNet, mosaic augmentation, auto-anchor
     * YOLOv8 (Ultralytics, 2023): anchor-free, decoupled head, CIoU loss
   - Include Table: "Table 2.3: YOLO Version Comparison"
     | Version | Year | Key Innovation | mAP (COCO) | Speed (FPS) |
   - Justification for selecting YOLOv8 for FireGuard:
     * Real-time performance, anchor-free design, Ultralytics ecosystem,
       easy fine-tuning, Python API, active community support
   - Reference real papers: Redmon et al. (2016), Bochkovskiy et al. (2020),
     Jocher et al. (YOLOv5/v8 documentation)

2.5 DEEP LEARNING FRAMEWORKS (500–700 words)
   - TensorFlow vs. PyTorch comparison
   - Why PyTorch was chosen for FireGuard (Ultralytics built on PyTorch)
   - Include Table: "Table 2.4: PyTorch vs. TensorFlow Comparison"
     | Feature | PyTorch | TensorFlow |
   - Reference Paszke et al. (2019) for PyTorch

2.6 BACKEND AND API TECHNOLOGIES (600–800 words)
   - Web framework comparison: Django vs. Flask vs. FastAPI vs. Express.js
   - Why Django was chosen: mature, batteries-included, ORM, admin, DRF
   - RESTful API design principles (Fielding, 2000)
   - Token-based authentication review
   - Include Table: "Table 2.5: Backend Framework Comparison"
     | Feature | Django | Flask | FastAPI | Express.js |
   - Reference official Django and DRF documentation

2.7 MOBILE APPLICATION TECHNOLOGIES (600–800 words)
   - Cross-platform development: Flutter vs. React Native vs. Native
   - Flutter architecture: widget tree, Dart language, hot reload
   - State management patterns: Provider, BLoC, Riverpod, GetX
   - Why Flutter with Provider was chosen for FireGuard
   - Include Table: "Table 2.6: Mobile Framework Comparison"
     | Feature | Flutter | React Native | Kotlin/Swift |
   - Reference official Flutter documentation

2.8 PUSH NOTIFICATION SYSTEMS (400–600 words)
   - Firebase Cloud Messaging (FCM) overview
   - FCM vs. OneSignal vs. Pusher vs. custom WebSocket
   - Why FCM was chosen: Google-backed, free, cross-platform, reliable
   - Include Table: "Table 2.7: Push Notification Service Comparison"

2.9 DATABASE TECHNOLOGIES (400–600 words)
   - SQLite3 overview: serverless, zero-configuration, file-based
   - Comparison: SQLite3 vs. PostgreSQL vs. MySQL
   - Why SQLite3 was appropriate for the graduation project prototype
   - Django ORM as the abstraction layer
   - Include Table: "Table 2.8: Database Comparison"

2.10 RELATED WORK (800–1000 words)
   - Review at least 4–5 real published systems/papers that combine:
     * Computer vision for fire detection
     * Mobile notification systems
     * Edge computing for real-time inference
   - For each related work, describe: approach, technology, results, limitations
   - Include Table: "Table 2.9: Related Work Summary"
     | Study | Year | Detection Method | Platform | Notification | Limitations |
   - Discuss how FireGuard differs from and builds upon existing work
   - Reference ONLY real published papers (IEEE, Springer, Elsevier, ACM)

2.11 CHAPTER SUMMARY (200–300 words)
   - Summarize the key findings from the literature review
   - Link findings to FireGuard's design decisions

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Chapter title: 16 pt bold ("Chapter 2: Literature Review")
- Main section headings (2.1, 2.2, etc.): 14 pt bold
- Subsection headings (2.1.1, etc.): 13 pt bold
- Line spacing: 1.5
- Text alignment: Justified
- Standard A4 page size
- All figures must have captions: "Figure 2.Y: [Description]"
- All tables must have captions: "Table 2.Y: [Description]"
- Suggest page breaks between major sections

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Every technical claim must be supported by a citation
- Do NOT fabricate citations — use real, verifiable references only
- Do NOT use fake DOIs, fake authors, or broken URLs
- Verify all references are real before including them

REFERENCES (minimum 20 references):
- Real YOLO papers: Redmon et al. (2016), Bochkovskiy et al. (2020)
- Real PyTorch paper: Paszke et al. (2019)
- Real OpenCV references: Bradski (2000)
- Real fire detection papers from IEEE, Springer, Elsevier
- Real mobile development references
- Official documentation: Ultralytics, Django, Flutter, Firebase, SQLite
- Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.

End the chapter with:
## References
(formatted in IEEE style)

DIAGRAMS AND VISUALS:
- Include comparison tables wherever specified
- Include figure placeholders for diagrams of algorithm architectures
- Include a Mermaid diagram showing the evolution of YOLO versions

TOKEN OPTIMIZATION:
- Target output: approximately 10–15 Word pages
- If output must be split, clearly indicate the split point and provide
  a continuation prompt
```

</details>

---

<br/>

---

# 3 — 🔧 System Analysis and Design

<details>
<summary><b>Click to expand full prompt (Chapter 3: ~10–12 pages)</b></summary>

```
You are a senior academic engineering writer with expertise in software engineering,
systems analysis, UML modeling, and software architecture. You are writing the
SYSTEM ANALYSIS AND DESIGN CHAPTER (Chapter 3) for a graduation project book
submitted to a university engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

REAL ARCHITECTURE (use ONLY this):
- Three-tier architecture: Edge Tier (AI Service) + Backend Tier (Django) +
  Client Tier (Flutter)
- AI Service: camera.py + YOLOv8 (best.pt) + OpenCV. Runs on local machine.
  Captures webcam frames, runs inference (conf=0.5), saves annotated snapshots,
  POSTs to Django backend. 10-second cooldown between alerts.
- Backend: Django 5.2 + DRF 3.17. Four Django apps: accounts, cameras, events,
  notifications. SQLite3 database. Firebase Admin SDK for FCM.
  Deployed on PythonAnywhere (bodareda0001.pythonanywhere.com).
- Mobile App: Flutter 3.9. Provider state management. Dio HTTP client.
  GoRouter navigation. Firebase Messaging + flutter_local_notifications.
  Local SQLite for notification cache.
- Communication: HTTP REST (AI→Backend, Mobile→Backend), FCM (Backend→Mobile)

DJANGO APPS AND MODELS:
- accounts: UserProfile (user, phone, avatar)
- cameras: Zone (name, description), Camera (zone FK, name, location, stream_url,
  thumbnail, status[online/offline])
- events: FireEvent (camera FK, event_type[fire/smoke], status[active/resolved/
  false_alarm], ai_confidence, snapshot, notes, detected_at, resolved_at)
- notifications: FCMDevice (user FK, token, platform, is_active),
  NotificationPreference (user OneToOne, fire_alerts, resolved_alerts,
  false_alarm_alerts, sound_enabled)

API ENDPOINTS:
- POST /api/events/ (AllowAny — used by AI service)
- GET/PATCH /api/events/{id}/, GET /api/events/active/, GET /api/events/stats/
- PATCH /api/events/{id}/resolve/, PATCH /api/events/{id}/false-alarm/
- POST /api/auth/register/, POST /api/auth/login/, POST /api/auth/logout/
- GET/PATCH /api/auth/profile/, POST /api/auth/change-password/
- GET/POST /api/cameras/zones/, GET/POST /api/cameras/cameras/
- POST /api/notifications/register-device/, GET/PATCH /api/notifications/preferences/

FLUTTER SCREENS:
Splash, Login, Signup, ForgotPassword, Home (Dashboard), Cameras, CameraDetail,
EditCamera, ActivityHistory, Alert, Settings, Profile

TERMINOLOGY (use consistently):
- FireEvent, AI Camera Node, Detection Event, Confidence Threshold,
  Active Event, Notification Payload, Edge Node, Inference Pipeline,
  Cooldown, Snapshot, AlertPayload

══════════════════════════════════════════════════════════
CHAPTER 3 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Present the systematic analysis and design of the FireGuard system including
functional/non-functional requirements, use case analysis, data flow diagrams,
system architecture, and component design.

3.1 INTRODUCTION (300–400 words)
   - Purpose of the system analysis and design phase
   - Overview of the methodologies used (structured analysis, UML)
   - Chapter roadmap

3.2 REQUIREMENTS ANALYSIS (800–1000 words)
   3.2.1 Functional Requirements
   - List ALL functional requirements as a numbered table:
     "Table 3.1: Functional Requirements"
     | FR-ID | Requirement | Priority | Component |
     Include requirements for: detection, event management, authentication,
     camera management, notification, mobile UI
   3.2.2 Non-Functional Requirements
   - "Table 3.2: Non-Functional Requirements"
     | NFR-ID | Requirement | Category | Target |
     Include: performance (real-time inference), reliability, usability,
     portability (cross-platform mobile), security (token auth)

3.3 USE CASE ANALYSIS (800–1000 words)
   - Identify actors: AI Camera Node, Mobile User, Admin User, Firebase Cloud
   - Include a Mermaid use case diagram showing all actors and use cases
   - Detailed use case descriptions for at least 4 key use cases:
     1. "Detect Fire/Smoke" (AI Camera Node → System)
     2. "View and Manage Events" (Mobile User → System)
     3. "Resolve Fire Event" (Mobile User → System)
     4. "Manage Cameras and Zones" (Admin User → System)
   - For each use case, provide:
     * Use Case ID, Name, Actor, Precondition, Main Flow, Alternative Flow,
       Postcondition

3.4 SYSTEM ARCHITECTURE DESIGN (1000–1200 words)
   3.4.1 Three-Tier Architecture
   - Edge Tier: AI Camera Node (camera.py + YOLOv8 + OpenCV)
   - Backend Tier: Django 5.2 + DRF + SQLite3 + Firebase Admin SDK
   - Client Tier: Flutter 3.9 + Provider + Dio + FCM
   - Include a Mermaid architecture diagram showing all three tiers with
     subcomponents and communication paths
   3.4.2 Component Communication
   - Communication protocols: HTTP REST (AI→Backend, Mobile→Backend),
     FCM push (Backend→Firebase→Mobile)
   - Include Table: "Table 3.3: Communication Paths"
     | Path | Protocol | Auth | Description |
   3.4.3 Deployment Architecture
   - PythonAnywhere (backend), Local machine (AI), Android device (Flutter)
   - Include a Mermaid deployment diagram

3.5 DATA FLOW DIAGRAMS (800–1000 words)
   3.5.1 Context Diagram (DFD Level 0)
   - Include a Mermaid DFD Level 0 diagram:
     External Camera → FireGuard System → Mobile User
     Mobile User → FireGuard System (resolve commands)
     Admin User → FireGuard System (camera/zone management)
   3.5.2 DFD Level 1
   - Include a Mermaid DFD Level 1 diagram with processes:
     P1: AI Detection (camera.py + YOLOv8)
     P2: Event Management (events app)
     P3: Notification Dispatch (fcm.py)
     P4: Mobile Alert (Flutter)
     P5: Camera Management (cameras app)
     P6: Authentication (accounts app)
   - Data stores: SQLite3 tables (FireEvent, Camera, Zone, User,
     FCMDevice, NotificationPreference)

3.6 SEQUENCE DIAGRAMS (600–800 words)
   - Include Mermaid sequence diagrams for:
     1. Event Creation Flow: camera.py → Django API → SQLite3 → fcm.py →
        Firebase → Flutter App
     2. Event Resolution Flow: Flutter App → Django API → SQLite3 →
        fcm.py → Firebase → Flutter App
     3. User Authentication Flow: Flutter App → Django API → SQLite3 →
        Return Token → Store in SharedPreferences

3.7 ACTIVITY DIAGRAM (400–500 words)
   - Include a Mermaid activity diagram for the complete system flow:
     Start → Initialize Camera → Load YOLO Model → Read Frame → Inference →
     Detection? → Cooldown? → Save Snapshot → POST to API → Create FireEvent →
     Send FCM → Display Alert → User Action (Resolve/False Alarm) → End

3.8 CLASS DIAGRAM (400–500 words)
   - Include a Mermaid class diagram showing Django models and their relationships:
     User, UserProfile, Zone, Camera, FireEvent, FCMDevice, NotificationPreference,
     Token
   - Show relationships: OneToOne, ForeignKey, CASCADE

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Chapter title: 16 pt bold ("Chapter 3: System Analysis and Design")
- Main section headings (3.1, 3.2, etc.): 14 pt bold
- Subsection headings (3.1.1, etc.): 13 pt bold
- Line spacing: 1.5
- Text alignment: Justified
- Standard A4 page size
- All figures must have captions: "Figure 3.Y: [Description]"
- All tables must have captions: "Table 3.Y: [Description]"
- Suggest page breaks between major sections

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Do NOT fabricate citations — use real, verifiable references only

REFERENCES (minimum 8 references):
- Software engineering textbooks (Pressman, Sommerville)
- UML references (Booch, Rumbaugh)
- REST API design (Fielding 2000)
- Official framework documentation
- Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.

End the chapter with:
## References
(formatted in IEEE style)

DIAGRAMS AND VISUALS:
- Include ALL Mermaid diagrams specified above
- Include ALL tables specified above
- The diagrams are the core deliverable of this chapter

TOKEN OPTIMIZATION:
- Target output: approximately 10–12 Word pages
- If output must be split, clearly indicate the split point and provide
  a continuation prompt
```

</details>

---

<br/>

---

# 4 — 🧠 AI Development Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 4: ~12–15 pages)</b></summary>

```
You are a senior academic engineering writer with deep expertise in deep learning,
computer vision, object detection, and PyTorch. You are writing the AI DEVELOPMENT
CHAPTER (Chapter 4) for a graduation project book submitted to a university
engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM CONTEXT (for context only — focus this chapter on the AI pipeline):
- Three-tier architecture: Edge (AI Service) + Backend (Django) + Client (Flutter)
- Database: SQLite3 ONLY
- Notifications: Firebase Cloud Messaging
- Camera: External WiFi camera connected through USB, used as webcam input
  via OpenCV cv2.VideoCapture(0)
- There is NO FastAPI, NO Docker, NO microservices. The AI service is a
  standalone Python script (camera.py) that runs locally.

AI SERVICE TECHNICAL DETAILS:
- Script: ai_service/camera.py (standalone Python script, NOT a web service)
- Model: YOLOv8 (Ultralytics YOLO class) — custom-trained on fire/smoke dataset
- Weights file: best.pt (stored in ai_service/ directory)
- Runtime: PyTorch (CPU or GPU inference, GPU optional)
- Target classes: fire (class 0), smoke (class 1) — 2 classes only
- Confidence threshold: 0.5 (50%), set via model(frame, conf=0.5, stream=True)
- Frame capture: OpenCV cv2.VideoCapture(0)
- Cooldown: 10-second minimum interval between consecutive alerts
- Snapshot: Annotated JPEG saved as alert_YYYYMMDD_HHMMSS.jpg via cv2.imwrite()
- Backend reporting: HTTP POST /api/events/ (multipart form data with snapshot)
- Display: cv2.imshow() for live detection visualization
- API URL: https://bodareda0001.pythonanywhere.com/api/events/
- CAMERA_ID: 1 (hardcoded reference to camera record in backend)

ACTUAL camera.py WORKFLOW:
1. Load YOLO model: model = YOLO('best.pt')
2. Open webcam: cap = cv2.VideoCapture(0)
3. Loop: read frame → model(frame, conf=0.5, stream=True)
4. Parse results: r.plot() for annotation, extract cls_id, confidence, label
5. First detection only (break after first box)
6. Cooldown check: current_time - last_sent_time > 10s
7. Save snapshot: cv2.imwrite(f"alert_{timestamp}.jpg", annotated_frame)
8. POST to backend: requests.post(API_URL, files={"snapshot": img}, data={...})
9. Reset cooldown only on HTTP 201
10. Display: cv2.imshow("Fire & Smoke Detection", annotated_frame)
11. Quit on 'q' key press

POST REQUEST FIELDS:
- camera: 1 (integer, FK to Camera record)
- event_type: "fire" or "smoke" (from YOLO class name)
- ai_confidence: 0–100 (YOLO 0.0–1.0 × 100)
- notes: "Detected automatically by AI system"
- snapshot: JPEG file (multipart upload)

AI DEPENDENCIES:
- ultralytics ≥ 8.0.0, < 9.0.0
- opencv-python ≥ 4.8.0, < 5.0.0
- torch ≥ 2.0.0, < 3.0.0
- numpy ≥ 1.24.0, < 2.0.0
- pillow ≥ 10.0.0, < 13.0.0
- requests ≥ 2.28.0, < 3.0.0

AI TEAM MEMBERS: Ali Khaled Abo Raya, Mohamed Abdelfatah Attalah, Mohamed Asaad

TERMINOLOGY (use consistently):
- AI Camera Node, Edge Node, Detection Event, Confidence Threshold,
  Inference Pipeline, Cooldown, Snapshot, FireEvent

══════════════════════════════════════════════════════════
CHAPTER 4 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Document the complete AI development process including dataset preparation,
model training, inference pipeline implementation, and camera integration.

4.1 CHAPTER INTRODUCTION (500–700 words)
   - Role of the AI component as the detection engine of FireGuard
   - Why computer vision was chosen over traditional sensors
   - High-level pipeline overview:
     Camera → Frame Capture → Preprocessing → YOLOv8 Inference →
     Post-processing → Cooldown Check → Snapshot → Backend Notification
   - Include a Mermaid flowchart of the complete AI pipeline
   - Include a Key Design Decisions Table:
     | Decision | Options Considered | Chosen | Justification |
     (Cover: model architecture, confidence threshold, cooldown period,
      camera input method, snapshot format)

4.2 DATASET COLLECTION AND PREPARATION (1200–1500 words)
   - Data collection strategy: public fire/smoke datasets, web sources, custom captures
   - Dataset diversity: indoor, outdoor, day, night, different fire types, negatives
   - Include Table: "Table 4.1: Dataset Sources"
     | Source | Type | Image Count | Notes |
   - Annotation methodology: Roboflow platform, YOLO annotation format
   - YOLO annotation format with mathematical formulation:
     center_x = (x_min + x_max) / (2 × image_width)
   - Include example annotation file in a code block
   - Dataset statistics (use [X] placeholders for actual values):
     Total images: [X], Train/Val/Test split: [X]%/[X]%/[X]%
     Class distribution: fire [X] instances, smoke [X] instances
   - Include Table: "Table 4.2: Dataset Split Summary"
   - Preprocessing steps: auto-orient, resize, normalization
   - Augmentation techniques table:
     | Technique | Parameters | Purpose |
   - Include a Mermaid flowchart:
     Raw Images → Upload to Roboflow → Annotate → Preprocess → Augment →
     Export (YOLOv8 format)
   - Figure placeholders for annotated sample images

4.3 YOLOv8 MODEL ARCHITECTURE (800–1000 words)
   - YOLOv8 architecture overview: backbone (CSPDarknet), neck (FPN+PAN), head
   - Anchor-free detection design
   - Decoupled head for classification and regression
   - YOLOv8 variant selection table:
     | Variant | Parameters | FLOPs | mAP (COCO) | Chosen? |
   - Explain which variant was selected and why
   - Include a Mermaid diagram or figure placeholder showing YOLOv8 architecture

4.4 MODEL TRAINING (1000–1500 words)
   - Transfer learning: COCO pre-trained weights, fine-tuning strategy
   - Training hyperparameters table:
     | Parameter | Value | Justification |
     (epochs, batch size, image size=640, learning rate, optimizer, weight decay,
      momentum, warmup epochs)
   - Training command (Python code block)
   - Loss functions with mathematical formulas:
     * Box loss (CIoU): L_CIoU = 1 - IoU + ρ²(b,b^gt)/c² + αv
     * Classification loss (Binary Cross-Entropy)
     * Distribution Focal Loss (DFL)
   - Evaluation metrics with formulas:
     * Precision = TP / (TP + FP)
     * Recall = TP / (TP + FN)
     * F1 = 2 × (P × R) / (P + R)
     * mAP@0.5 and mAP@0.5:0.95
   - Training results table (use [X] placeholders):
     | Metric | Fire | Smoke | Overall |
   - Figure placeholders: loss curves, mAP progression, confusion matrix,
     PR curve, F1-confidence curve
   - Model export: best.pt vs. last.pt, model size

4.5 PYTORCH AND ULTRALYTICS INTEGRATION (600–800 words)
   - PyTorch framework role in the ML ecosystem
   - Ultralytics library: how it wraps PyTorch
   - YOLO class API: load, train, predict, export
   - Model loading: model = YOLO('best.pt')
   - Inference call: model(frame, conf=0.5, stream=True)
   - Result processing: r.boxes, r.names, r.plot()
   - Include code snippets from the actual implementation

4.6 OPENCV INTEGRATION (600–800 words)
   - OpenCV role: frame capture and image processing
   - cv2.VideoCapture(0): opening the webcam
   - Frame reading: ret, frame = cap.read() — BGR numpy array
   - Snapshot generation: cv2.imwrite() with annotated frame from r.plot()
   - Live display: cv2.imshow() for operator monitoring during demo
   - Camera release and window cleanup

4.7 INFERENCE PIPELINE IMPLEMENTATION (1000–1200 words)
   - Complete pipeline walkthrough with code:
     1. Initialize model and camera
     2. Main loop: read frame
     3. Run YOLO inference
     4. Parse results: extract class ID, confidence, label
     5. First detection selection (break after first box)
     6. Cooldown check: time.time() - last_sent_time > 10
     7. Save annotated snapshot
     8. HTTP POST to backend (multipart form data)
     9. Reset cooldown on HTTP 201
     10. Display annotated frame
     11. Exit on 'q' key
   - Include a Mermaid state diagram for the cooldown mechanism
   - Include a Mermaid flowchart for the complete runtime processing flow
   - Confidence transformation: YOLO 0.0–1.0 → ai_confidence 0–100

4.8 BACKEND EVENT REPORTING (400–500 words)
   - POST /api/events/ request format (multipart form data)
   - Request fields: camera, event_type, ai_confidence, notes, snapshot
   - Response handling: HTTP 201 → reset cooldown, other → log error
   - Include the actual request/response JSON examples

4.9 LIMITATIONS AND FUTURE IMPROVEMENTS (300–400 words)
   - Single camera only (hardcoded CAMERA_ID=1)
   - No authentication on event creation endpoint
   - Local snapshot storage (no automatic cleanup)
   - Hardcoded API URL
   - First detection only (single box per frame)
   - CPU inference speed dependency
   - Future: multi-camera support, GPU acceleration, model retraining pipeline

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman
- Body text: 12 pt
- Chapter title: 16 pt bold ("Chapter 4: AI Development")
- Main section headings (4.1, 4.2, etc.): 14 pt bold
- Subsection headings (4.1.1, etc.): 13 pt bold
- Line spacing: 1.5
- Text alignment: Justified
- Standard A4 page size
- All figures must have captions: "Figure 4.Y: [Description]"
- All tables must have captions: "Table 4.Y: [Description]"
- Suggest page breaks between major sections

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- In-text citations using IEEE style: [1], [2], [3]
- Do NOT fabricate citations — use real, verifiable references only

REFERENCES (minimum 15 references):
- Real YOLO papers: Redmon et al. (2016), Bochkovskiy et al. (2020),
  Jocher et al. (YOLOv5/v8)
- Real PyTorch: Paszke et al. (2019)
- Real OpenCV: Bradski (2000)
- Real fire detection papers from IEEE/Springer/Elsevier
- Official Ultralytics documentation (docs.ultralytics.com)
- Official Roboflow documentation
- Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year. DOI/URL.

End the chapter with:
## References
(formatted in IEEE style)

DIAGRAMS AND VISUALS:
- Include ALL Mermaid diagrams specified above
- Include ALL tables specified above
- Include figure placeholders for: training curves, confusion matrix, sample
  detections, architecture diagrams

TOKEN OPTIMIZATION:
- Target output: approximately 12–15 Word pages
- If output must be split, clearly indicate the split point and provide
  a continuation prompt
```

</details>

---

<br/>

---

# 5 — 🖥️ Backend Development Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 5: ~10–12 pages)</b></summary>

```
You are a senior academic engineering writer specializing in backend development,
REST API design, web security, and push notification systems. You are writing the
BACKEND DEVELOPMENT CHAPTER (Chapter 5) for a graduation project book submitted
to a university engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM CONTEXT (for context only — focus this chapter on the backend):
- Three-tier architecture: Edge (AI Service) + Backend (Django) + Client (Flutter)
- There is NO FastAPI, NO Docker, NO Docker Compose, NO microservices.
- The AI service is a standalone Python script (camera.py) that sends HTTP POST
  requests to the Django backend.

BACKEND TECHNICAL DETAILS:
- Framework: Django 5.2 + Django REST Framework (DRF) 3.17
- Database: SQLite3 (db.sqlite3, file-based, managed by Django ORM)
- Authentication: DRF Token Authentication (rest_framework.authtoken)
- Push notifications: Firebase Admin SDK 7.4 (firebase_admin Python package)
- CORS: django-cors-headers (CORS_ALLOW_ALL_ORIGINS = True — development setting)
- Environment: python-dotenv for .env loading
- Deployment: PythonAnywhere (bodareda0001.pythonanywhere.com), WSGI
- Default permission: IsAuthenticated on all endpoints (except POST /api/events/)
- Pagination: PageNumberPagination, PAGE_SIZE=20

DJANGO PROJECT STRUCTURE:
backend/
├── fireguard/          # Project config (settings.py, urls.py, firebase.py, wsgi.py)
├── accounts/           # User authentication & profiles
├── cameras/            # Camera & zone management
├── events/             # Fire event lifecycle
├── notifications/      # FCM device & notification management
├── manage.py
├── requirements.txt
└── firebase_credentials.json (not in VCS)

DJANGO APPS AND MODELS:
- accounts: UserProfile (user OneToOne, phone, avatar) — auto-created via post_save signal
- cameras: Zone (name, description), Camera (zone FK, name, location, stream_url,
  thumbnail, status[online/offline])
- events: FireEvent (camera FK, event_type[fire/smoke], status[active/resolved/
  false_alarm], ai_confidence, snapshot, notes, detected_at, resolved_at)
  Ordered by -detected_at. Status lifecycle: active → resolved | false_alarm
- notifications: FCMDevice (user FK, token unique, platform, is_active),
  NotificationPreference (user OneToOne, fire_alerts, resolved_alerts,
  false_alarm_alerts, sound_enabled) — auto-created via post_save signal

DRF CONFIGURATION:
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': ['rest_framework.authentication.TokenAuthentication'],
    'DEFAULT_PERMISSION_CLASSES': ['rest_framework.permissions.IsAuthenticated'],
    'DEFAULT_PAGINATION_CLASS': 'rest_framework.pagination.PageNumberPagination',
    'PAGE_SIZE': 20,
}

COMPLETE API ENDPOINTS:

Authentication (/api/auth/):
- POST /register/ — AllowAny — Create user + UserProfile + NotificationPreference + Token
- POST /login/ — AllowAny — Authenticate, return token
- POST /logout/ — IsAuthenticated — Delete token
- GET /profile/ — IsAuthenticated — Get profile
- PATCH /profile/ — IsAuthenticated — Update profile (name, email, phone, avatar)
- POST /change-password/ — IsAuthenticated — Change password, regenerate token

Cameras (/api/cameras/):
- GET /zones/ — Authenticated — List zones with camera_count annotation
- POST /zones/ — Admin (IsAdminOrReadOnly) — Create zone
- GET/PUT/PATCH/DELETE /zones/{id}/ — Admin for write, Authenticated for read
- GET /cameras/ — Authenticated — List cameras (filterable by zone, status)
- POST /cameras/ — Admin — Create camera
- GET/PUT/PATCH/DELETE /cameras/{id}/ — Admin for write, Authenticated for read
- PATCH /cameras/{id}/status/ — Admin — Update camera status
- GET /stats/ — Authenticated — Camera statistics (total, online, offline)

Events (/api/events/):
- GET / — IsAuthenticated — List events (filterable by status, camera, zone, type)
- POST / — AllowAny — Create event (used by AI service camera.py)
- GET /{id}/ — IsAuthenticated — Event detail
- PATCH /{id}/ — IsAuthenticated — Update event notes
- PATCH /{id}/resolve/ — IsAuthenticated — Set status=resolved, resolved_at=now
- PATCH /{id}/false-alarm/ — IsAuthenticated — Set status=false_alarm
- GET /active/ — IsAuthenticated — Most recent active event
- GET /stats/ — IsAuthenticated — Aggregate counts {total, fire, smoke, active, resolved, false_alarm}

Notifications (/api/notifications/):
- POST /register-device/ — IsAuthenticated — Register/update FCM token
- DELETE /unregister-device/ — IsAuthenticated — Deactivate FCM token
- GET /preferences/ — IsAuthenticated — Get notification preferences
- PATCH /preferences/ — IsAuthenticated — Update preferences
- POST /test-push/ — IsAuthenticated — Send test push notification

FIREBASE INTEGRATION:
- Firebase initialization: firebase.py → NotificationsConfig.ready() → initialize_firebase()
- Idempotent init: checks firebase_admin._apps before initializing
- FCM functions in notifications/fcm.py:
  * send_fire_alert_to_all(event): Query users with fire_alerts=True, fetch active tokens,
    build MulticastMessage (notification + data payload), send_each_for_multicast
  * send_resolved_alert(event): Query users with resolved_alerts=True, send resolved notification
  * send_test_push(token): Send test to single device
- Failed token handling: deactivate is_active=False for failed FCM tokens

NOTIFICATION PAYLOAD:
notification: { title: "🔥 Fire Detected!", body: "Building 3, Floor 2 — 87.5%" }
data: { type, event_id, camera_id, camera_name, location, zone, event_type,
        ai_confidence, detected_at }

SERIALIZERS:
RegisterSerializer, UserSerializer, UserProfileSerializer, UpdateProfileSerializer,
ChangePasswordSerializer, ZoneSerializer (annotated camera_count), CameraSerializer
(zone_name), CameraStatusSerializer, FireEventSerializer (nested camera_detail),
FireEventCreateSerializer (validates ai_confidence 0-100, camera not offline),
FireEventUpdateSerializer, FCMDeviceSerializer, NotificationPreferenceSerializer

BACKEND DEPENDENCIES:
Django 5.2.13, djangorestframework 3.17.1, django-cors-headers 4.9.0,
firebase_admin 7.4.0, python-dotenv 1.2.2, pillow 12.2.0, requests 2.33.1,
gunicorn 21.2.0

BACKEND TEAM MEMBER: Abdelrahman Reda Abdellah

TERMINOLOGY (use consistently):
- FireEvent, Active Event, Detection Event, Notification Payload, Cooldown,
  Snapshot, FCM, DRF, Token Authentication, Zone, MulticastMessage

══════════════════════════════════════════════════════════
CHAPTER 5 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Document the complete backend implementation including Django project structure,
DRF API design, authentication system, Firebase notification integration, and
the event lifecycle management.

5.1 CHAPTER INTRODUCTION (600–800 words)
   - Backend role: central business logic, data persistence, API gateway,
     event receiver from AI service, notification dispatcher
   - Technology justification table:
     | Technology | Version | Purpose | Why Chosen |
   - Django project structure overview with directory tree
   - Include a Mermaid diagram showing Django app architecture and relationships
   - How the backend connects AI service, database, Firebase, and mobile app

5.2 DJANGO REST FRAMEWORK API DESIGN (1500–2000 words)
   - RESTful API design principles: resource naming, HTTP methods, status codes
   - Complete endpoint documentation for ALL four API groups:
     For each endpoint group, provide a table with:
     | Method | Endpoint | Permission | Description |
   - Include JSON code blocks for key request/response examples:
     * Register request/response
     * Login request/response
     * Create event request/response (multipart)
     * Event stats response
     * Register device request/response
   - Serializer architecture: validation, nested serialization, custom validation
     (ai_confidence range, camera status check)
   - View architecture: APIView, custom actions, permission classes
   - URL routing: Django URL config, include() pattern
   - Include a Mermaid diagram showing URL routing structure

5.3 AUTHENTICATION AND SECURITY (800–1000 words)
   - Token-based authentication flow with Mermaid sequence diagram:
     Register → Create User + Profile + Preferences → Generate Token →
     Login → Validate → Return Token → Subsequent requests with header →
     Logout → Delete Token
   - DRF TokenAuthentication mechanism
   - Permission model: IsAuthenticated (default), AllowAny (POST /api/events/),
     IsAdminOrReadOnly (cameras/zones write operations)
   - Password handling: Django PBKDF2 + SHA256 hashing
   - Security assessment table:
     | Aspect | Implementation | Notes |
     (Token Auth, CORS, Firebase credentials, AllowAny on event creation)

5.4 FIREBASE NOTIFICATION SYSTEM (1000–1200 words)
   - FCM overview and architecture
   - Backend implementation:
     * Firebase initialization (firebase.py → AppConfig.ready())
     * send_fire_alert_to_all(event): flow with query preferences → collect tokens
       → MulticastMessage → send → handle failures
     * send_resolved_alert(event): same pattern for resolved events
     * send_test_push(token): single device test
   - Notification payload structure (notification + data blocks)
   - Include a Mermaid sequence diagram for the complete notification flow
   - Failed token handling: deactivate invalid tokens
   - Platform configuration: Android (priority=high, channel=alerts),
     APNS (priority=10, sound=default)
   - Include Table: "Table 5.X: Notification Types"
     | Type | Trigger | Recipients | Payload |

5.5 EVENT LIFECYCLE MANAGEMENT (500–700 words)
   - FireEvent status lifecycle: active → resolved | false_alarm
   - Include a Mermaid state diagram for event status transitions
   - Event creation from AI service (AllowAny, multipart form)
   - Event resolution and false alarm marking
   - Event statistics aggregation
   - Event filtering and pagination

5.6 LIMITATIONS AND FUTURE IMPROVEMENTS (300–400 words)
   - AllowAny on event creation (should use API key)
   - CORS_ALLOW_ALL_ORIGINS (development setting)
   - SQLite3 concurrency limitations
   - No automated testing
   - Manual deployment
   - Future: API key auth for AI service, rate limiting, automated tests

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING (for Microsoft Word export):
- Font: Times New Roman, Body: 12pt, Chapter title: 16pt bold,
  Sections: 14pt bold, Subsections: 13pt bold
- Line spacing: 1.5, Justified, A4
- All figures: "Figure 5.Y: [Description]"
- All tables: "Table 5.Y: [Description]"
- Page breaks between major sections

ACADEMIC STYLE:
- Formal academic engineering tone, third person
- IEEE citations: [1], [2], [3]
- Do NOT fabricate citations

REFERENCES (minimum 10 references):
- Official Django documentation (djangoproject.com)
- Official DRF documentation (django-rest-framework.org)
- Official Firebase documentation (firebase.google.com)
- REST API design (Fielding 2000)
- Web security references (OWASP)
- Format: [#] Author(s), "Title," Source, Month Year. DOI/URL.

End the chapter with:
## References
(formatted in IEEE style)

TOKEN OPTIMIZATION:
- Target: approximately 10–12 Word pages
- If split needed, indicate clearly with continuation prompt
```

</details>

---

<br/>

---

# 6 — 📱 Mobile Application & UI/UX Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 6: ~10–12 pages)</b></summary>

```
You are a senior academic engineering writer specializing in mobile application
development, Flutter, state management, and UI/UX design. You are writing the
MOBILE APPLICATION & UI/UX CHAPTER (Chapter 6) for a graduation project book
submitted to a university engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

SYSTEM CONTEXT (for context only — focus this chapter on the mobile app):
- Three-tier: Edge (AI Service) + Backend (Django 5.2 + SQLite3) + Client (Flutter)
- Backend deployed on PythonAnywhere (bodareda0001.pythonanywhere.com)
- Push notifications via Firebase Cloud Messaging (FCM)

FLUTTER TECHNICAL DETAILS:
- Framework: Flutter 3.9 / Dart
- Architecture: Feature-first directory structure with shared core layer
- State management: Provider 6.1.5 (ChangeNotifier-based)
- HTTP client: Dio 5.9.2 with token interceptor
- Navigation: GoRouter 17.2.1 (declarative routing)
- Push notifications: firebase_core, firebase_messaging 16.2.2
- Local notifications: flutter_local_notifications 18.0.1 with custom fire_alarm sound
- Local database: sqflite 2.4.1 (fire_guard.db for notification cache)
- Responsive sizing: flutter_screenutil 5.9.3 (designSize: 360×690)
- Token storage: SharedPreferences (via CacheHelper)
- Date formatting: intl 0.20.2
- Image selection: image_picker 1.2.2

FLUTTER PROJECT STRUCTURE:
lib/
├── main.dart                    # Entry point
├── fire_gaurd.dart              # Root widget (MultiProvider + MaterialApp.router)
├── firebase_options.dart        # Generated Firebase config
├── core/                        # Shared infrastructure
│   ├── constant/                # Route name constants
│   ├── error/                   # Exception classes
│   ├── models/                  # ActivityEvent, Camera, AlertPayload
│   ├── navigation/              # GoRouter configuration
│   ├── services/                # ApiService, CacheHelper, DatabaseService, FirebaseNotifications
│   ├── theme/                   # AppTheme, AppColors, AppTextStyle
│   └── widgets/                 # Shared UI components
└── feature/                     # Feature modules
    ├── splash/                  # Auto-login check
    ├── auth/                    # Login, Signup, Forgot Password
    ├── home/                    # Dashboard
    ├── cameras/                 # Camera CRUD
    ├── activity/                # Event history
    ├── alert/                   # Real-time fire alert
    ├── notification/            # Notification history
    └── settings/                # Settings, Profile

PROVIDER REGISTRY (registered via MultiProvider in fire_gaurd.dart):
- Provider<ApiService>: Singleton Dio HTTP client with token interceptor
- ProxyProvider<ApiService, AuthRepository>: Auth API calls
- ProxyProvider<ApiService, CameraRepository>: Camera/Zone API calls
- ProxyProvider<ApiService, ActivityRepository>: Event history API calls
- ChangeNotifierProvider<AuthProvider>: Login/logout state, token persistence
- ChangeNotifierProvider<CameraProvider>: Camera list state, CRUD
- ChangeNotifierProvider<HomeProvider>: Dashboard statistics
- ChangeNotifierProvider<ActivityProvider>: Event history, resolve actions

SCREENS AND ROUTES:
| Screen | Route Path | Description |
| SplashScreen | / | Auto-login check (cached token → Home, else → Login) |
| LoginScreen | /login | Username/password login |
| SignupScreen | /Singup | Registration form |
| ForgotPasswordScreen | /forgotPassword | Password recovery |
| HomeScreen | /home | Dashboard with stats and quick actions |
| CamerasScreen | /livecamere | Camera list with zone filtering |
| CameraDetailScreen | /camera/:id | Camera details + events |
| EditCameraScreen | /editCamera | Camera edit form |
| ActivityHistoryScreen | /activityHistory | Event history list |
| AlertScreen | /alert | Full-screen emergency alert |
| SettingsScreen | /settings | App settings |
| ProfileScreen | /profile | User profile editing |

NOTIFICATION HANDLING:
- FirebaseNotifications class manages all FCM functionality
- Foreground: onMessage → show local notification + broadcast via stream + store in local DB
- Background: _firebaseMessagingBackgroundHandler → store in local DB + show notification
- Terminated: getInitialMessage() → navigate to alert screen on app open
- Notification tap: onMessageOpenedApp → navigate to alert screen with AlertPayload
- Custom notification channel: 'fire_emergency_v3', Importance.max, fire_alarm sound
- FCM token registration: sent to backend after login/signup
- AlertPayload model: maps FCM data to Dart object (type, eventId, cameraId,
  cameraName, location, zone, eventType, aiConfidence, detectedAt)

LOCAL DATABASE (fire_guard.db):
CREATE TABLE notifications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT, event_id TEXT UNIQUE, camera_id TEXT, camera_name TEXT,
    location TEXT, zone TEXT, event_type TEXT, ai_confidence REAL, detected_at TEXT
);
- Operations: insertNotification, getAllNotifications, clearAll
- UNIQUE constraint on event_id with ConflictAlgorithm.replace

API SERVICE (Dio):
- Base URL: https://bodareda0001.pythonanywhere.com/
- Token interceptor: reads from CacheHelper, adds "Authorization: Token {token}" header
- Timeout: 30 seconds connect/receive

MOBILE TEAM: Mohamed Hany El-Essawy, Saad Ezzat Saad

TERMINOLOGY (use consistently):
- AlertPayload, FireEvent, Active Event, Notification Payload, Provider,
  GoRouter, DatabaseService, ApiService

══════════════════════════════════════════════════════════
CHAPTER 6 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Document the complete Flutter mobile application including architecture,
state management, UI/UX design, notification handling, and screen implementations.

6.1 CHAPTER INTRODUCTION (600–800 words)
   - Flutter overview and advantages for this project
   - Cross-platform benefit (Android + iOS from single Dart codebase)
   - Widget-based declarative UI
   - Comparison table: Flutter vs. React Native vs. Native Development
   - Key dependencies table:
     | Package | Version | Purpose |
   - Include directory structure showing core/ vs. feature/ organization

6.2 APPLICATION ARCHITECTURE (800–1000 words)
   - Feature-first architecture pattern
   - Core layer: services, models, navigation, theme, widgets
   - Feature layer: independent feature modules
   - Include a Mermaid architecture diagram showing all layers and dependencies
   - Data flow: UI → Provider → Repository → ApiService → Backend → Response →
     State Update → UI Rebuild

6.3 STATE MANAGEMENT WITH PROVIDER (1000–1200 words)
   - State management comparison table:
     | Approach | Complexity | Boilerplate | Testability | Chosen? |
     (Provider, BLoC, Riverpod, GetX)
   - Provider architecture: ChangeNotifier, notifyListeners(), Consumer
   - MultiProvider setup at app root
   - Provider descriptions table:
     | Provider | Responsibility | Key State | Key Methods |
   - Include a Mermaid diagram of the provider dependency tree
   - Include a Mermaid sequence diagram showing data flow for a specific
     user action (e.g., "Load Home Dashboard")
   - Error handling: loading states, error messages, UI feedback

6.4 UI/UX DESIGN (1200–1500 words)
   - Design philosophy: safety-first emergency UX
   - Design system: AppTheme, AppColors, AppTextStyle
   - Responsive design with flutter_screenutil
   - Screen-by-screen walkthrough — for EACH screen describe:
     * Purpose, key UI elements, user interactions, navigation connections
     * Include figure placeholder: "Figure 6.Y: [ScreenName] — [insert screenshot]"
     Cover ALL screens: Splash, Login, Signup, Home, Cameras, CameraDetail,
     Activity History, Alert, Settings, Profile
   - Emergency UX design for AlertScreen:
     * Full-screen alert with event details
     * Resolution actions: "Mark Resolved" / "False Alarm" buttons
     * Event info: camera name, zone, event type, confidence, timestamp
     * Custom fire alarm sound notification
   - Color psychology in emergency UI: red for danger, green for resolved

6.5 NAVIGATION ARCHITECTURE (500–700 words)
   - GoRouter configuration: declarative routes, path parameters
   - Auth-guarded navigation (redirect to login if no cached token)
   - Deep linking from push notifications to alert screen
   - Include a Mermaid navigation flow diagram
   - Named routes table:
     | Route Name | Path | Screen |

6.6 NOTIFICATION HANDLING (800–1000 words)
   - FirebaseNotifications service architecture
   - FCM initialization, permission requests, token management
   - Notification handling by app state table:
     | App State | Handler | Behavior |
     (Foreground, Background, Terminated, Tap)
   - Local notification configuration (channel, sound, importance)
   - Include a Mermaid sequence diagram for the alert notification flow:
     FCM → FirebaseNotifications → Parse AlertPayload → Store in local DB →
     Broadcast stream → Show local notification → User taps → Navigate to AlertScreen
   - Notification stream: broadcast StreamController for real-time UI updates

6.7 LOCAL DATA PERSISTENCE (400–500 words)
   - Local SQLite database (fire_guard.db) via sqflite
   - Notification cache schema (notifications table)
   - DatabaseService: insertNotification, getAllNotifications, clearAll
   - Token storage via SharedPreferences (CacheHelper)

6.8 LIMITATIONS AND FUTURE IMPROVEMENTS (300–400 words)
   - Primarily tested on Android (iOS testing not performed)
   - No widget tests or integration tests
   - SharedPreferences for token (could use flutter_secure_storage)
   - No offline event viewing (requires backend connection)
   - Future: iOS testing, widget tests, secure storage, offline mode

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING: Times New Roman, 12pt body, 16pt chapter title,
14pt sections, 13pt subsections. 1.5 spacing, justified, A4.
Figures: "Figure 6.Y: [Description]", Tables: "Table 6.Y: [Description]"
Page breaks between major sections.

ACADEMIC STYLE: Formal third person, IEEE citations [1], [2].
Do NOT fabricate citations.

REFERENCES (minimum 10 references):
- Official Flutter documentation (flutter.dev)
- Official Dart documentation
- Provider package documentation
- Firebase Flutter documentation
- GoRouter documentation
- UI/UX references (Material Design, Nielsen Norman Group)
- Mobile accessibility references (WCAG)
- Format: [#] Author(s), "Title," Source, Month Year. DOI/URL.

End the chapter with:
## References
(formatted in IEEE style)

TOKEN OPTIMIZATION: Target 10–12 Word pages.
If split needed, indicate clearly with continuation prompt.
```

</details>

---

<br/>

---

# 7 — 💾 Database Design Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 7: ~8–10 pages)</b></summary>

```
You are a senior academic engineering writer specializing in database design,
data modeling, relational databases, and ORM systems. You are writing the
DATABASE DESIGN CHAPTER (Chapter 7) for a graduation project book submitted
to a university engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

CRITICAL: This project uses SQLite3 EXCLUSIVELY. There is NO PostgreSQL,
NO MySQL, NO Redis anywhere in the system. You may mention other databases
ONLY in comparison tables. Do NOT describe them as being used.

DATABASE CONFIGURATION:
Server-side: SQLite3 (backend/db.sqlite3, managed by Django ORM)
- Engine: django.db.backends.sqlite3
- Default PK: BigAutoField (64-bit auto-incrementing integer)
- Migration tool: python manage.py migrate

Client-side: Local SQLite (fire_guard.db on Flutter device via sqflite)
- Used for offline notification cache only

ALL DATABASE ENTITIES (from Django models):

1. User (Django built-in auth_user):
   id BigAutoField PK, username CharField(150) UNIQUE, email CharField(254),
   first_name CharField(150), last_name CharField(150), password CharField(128),
   is_staff BooleanField, is_active BooleanField, date_joined DateTimeField

2. UserProfile (accounts_userprofile):
   id BigAutoField PK, user_id OneToOneField→User CASCADE,
   phone CharField(20) nullable, avatar ImageField(avatars/) nullable,
   created_at DateTimeField auto_now_add, updated_at DateTimeField auto_now
   Auto-created via post_save signal on User creation.

3. Zone (cameras_zone):
   id BigAutoField PK, name CharField(100), description TextField nullable,
   created_at DateTimeField auto_now_add

4. Camera (cameras_camera):
   id BigAutoField PK, zone_id ForeignKey→Zone CASCADE,
   name CharField(100), location CharField(200),
   stream_url URLField nullable, thumbnail ImageField(cameras/) nullable,
   status CharField(10) choices=[online,offline] default=online,
   created_at DateTimeField auto_now_add, updated_at DateTimeField auto_now

5. FireEvent (events_fireevent):
   id BigAutoField PK, camera_id ForeignKey→Camera CASCADE,
   event_type CharField(10) choices=[fire,smoke],
   status CharField(15) choices=[active,resolved,false_alarm] default=active,
   ai_confidence FloatField (0.0–100.0),
   snapshot ImageField(snapshots/) nullable, notes TextField nullable,
   detected_at DateTimeField auto_now_add, resolved_at DateTimeField nullable
   Meta: ordering = ['-detected_at']

6. FCMDevice (notifications_fcmdevice):
   id BigAutoField PK, user_id ForeignKey→User CASCADE,
   token TextField UNIQUE, platform CharField(10) choices=[android,ios],
   is_active BooleanField default=True,
   created_at DateTimeField auto_now_add, updated_at DateTimeField auto_now

7. NotificationPreference (notifications_notificationpreference):
   id BigAutoField PK, user_id OneToOneField→User CASCADE,
   fire_alerts BooleanField default=True, resolved_alerts BooleanField default=True,
   false_alarm_alerts BooleanField default=False, sound_enabled BooleanField default=True,
   created_at DateTimeField auto_now_add, updated_at DateTimeField auto_now
   Auto-created via post_save signal on User creation.

8. Token (authtoken_token — DRF built-in):
   key CharField(40) PK UNIQUE, user_id OneToOneField→User,
   created DateTimeField auto_now_add

RELATIONSHIPS:
- User 1:1 UserProfile (CASCADE)
- User 1:1 NotificationPreference (CASCADE)
- User 1:1 Token (CASCADE)
- User 1:N FCMDevice (CASCADE)
- Zone 1:N Camera (CASCADE)
- Camera 1:N FireEvent (CASCADE)

CASCADE DELETION BEHAVIOR:
- Delete User → cascades to: UserProfile, NotificationPreference, FCMDevices, Token
- Delete Zone → cascades to: all Cameras → all FireEvents from those cameras
- Delete Camera → cascades to: all FireEvents from that camera

DJANGO ORM QUERY PATTERNS USED:
- select_related('camera', 'camera__zone') in events/views.py
- annotate(camera_count=Count('cameras')) in cameras/views.py
- filter() with query params (status, camera_id, zone, type)
- update_or_create() for FCMDevice token registration
- get_or_create() for Token on registration
- values_list('user_id', flat=True) for notification queries
- post_save signals for auto-creating UserProfile and NotificationPreference

CLIENT-SIDE DATABASE (Flutter):
CREATE TABLE notifications (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT, event_id TEXT UNIQUE, camera_id TEXT, camera_name TEXT,
    location TEXT, zone TEXT, event_type TEXT, ai_confidence REAL, detected_at TEXT
);
Operations: insertNotification (ConflictAlgorithm.replace), getAllNotifications
(ORDER BY detected_at DESC), clearAll

DATABASE TEAM MEMBER: Tarek Mostafa Kashef

TERMINOLOGY: FireEvent, Active Event, Zone, Snapshot, FCMDevice, NotificationPreference

══════════════════════════════════════════════════════════
CHAPTER 7 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Document the complete database design including schema, relationships,
ERD, normalization analysis, Django ORM integration, and query patterns.

7.1 CHAPTER INTRODUCTION (400–500 words)
   - Role of the database in FireGuard
   - SQLite3 overview: serverless, zero-configuration, file-based
   - Justification for choosing SQLite3 for the graduation project
   - Include Table: "Table 7.1: Database Technology Comparison"
     | Feature | SQLite3 | PostgreSQL | MySQL |
   - Dual database architecture: server-side (Django) + client-side (Flutter)

7.2 ENTITY RELATIONSHIP DIAGRAM (500–700 words)
   - Include a complete Mermaid ERD showing ALL 8 entities with:
     * All fields, types, and constraints
     * All relationships with cardinality
   - Describe each relationship and its business meaning
   - Include Table: "Table 7.2: Entity Relationships"
     | Relationship | Type | On Delete | Description |

7.3 DATABASE ENTITIES (1500–2000 words)
   - For EACH entity, provide:
     * Entity description and business purpose
     * Complete field table: | Field | Type | Constraints | Description |
     * Special behaviors (auto-creation via signals, ordering, status lifecycle)
   - Cover ALL 8 entities in detail
   - Include FireEvent status lifecycle state diagram (Mermaid)

7.4 NORMALIZATION ANALYSIS (500–700 words)
   - Analyze the database schema against normalization forms:
     * 1NF: atomic values, no repeating groups
     * 2NF: full functional dependency on primary key
     * 3NF: no transitive dependencies
   - Demonstrate that the schema satisfies 3NF
   - Include Table: "Table 7.3: Normalization Verification"

7.5 DJANGO ORM INTEGRATION (600–800 words)
   - How Django ORM maps models to SQLite3 tables
   - Migration management: makemigrations, migrate, showmigrations
   - Query patterns used in the project (with code examples):
     * select_related for JOIN optimization
     * annotate for aggregations
     * filter for conditional queries
     * update_or_create for upserts
     * post_save signals for auto-creation
   - Include Table: "Table 7.4: ORM Query Patterns"
     | Pattern | Location | Purpose |

7.6 EVENT STORAGE WORKFLOW (400–500 words)
   - Include a Mermaid sequence diagram:
     camera.py → DRF → Serializer validation → ORM → SQLite3 → Return
   - Validation rules: ai_confidence 0–100, camera not offline
   - Event creation → FCM notification trigger

7.7 CLIENT-SIDE DATABASE (400–500 words)
   - Flutter local SQLite (fire_guard.db) via sqflite
   - Schema: notifications table
   - DatabaseService operations
   - UNIQUE constraint and ConflictAlgorithm.replace
   - Purpose: offline notification history cache

7.8 LIMITATIONS AND FUTURE IMPROVEMENTS (300–400 words)
   - SQLite3 limited concurrent writes
   - No database backup strategy
   - No custom indexes beyond Django defaults
   - File-based storage limitations
   - Future: PostgreSQL migration, backup automation, custom indexes

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING: Times New Roman, 12pt body, 16pt chapter title,
14pt sections, 13pt subsections. 1.5 spacing, justified, A4.
Figures: "Figure 7.Y:", Tables: "Table 7.Y:"

ACADEMIC STYLE: Formal third person, IEEE citations.
Do NOT fabricate citations.

REFERENCES (minimum 8 references):
- Official SQLite documentation (sqlite.org)
- Official Django ORM documentation
- Database design textbooks (Elmasri & Navathe, Date)
- Normalization references
- Official sqflite documentation
- Format: [#] Author(s), "Title," Source, Month Year. DOI/URL.

End with: ## References (IEEE style)

TOKEN OPTIMIZATION: Target 8–10 Word pages.
```

</details>

---

<br/>

---

# 8 — 🚀 Deployment & Integration Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 8: ~6–8 pages)</b></summary>

```
You are a senior academic engineering writer specializing in software deployment,
system integration, and DevOps. You are writing the DEPLOYMENT & INTEGRATION
CHAPTER (Chapter 8) for a graduation project book submitted to a university
engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

CRITICAL RESTRICTIONS:
- There is NO Docker, NO Docker Compose, NO Kubernetes, NO CI/CD pipeline.
- There is NO microservices architecture.
- Deployment is MANUAL to PythonAnywhere (free tier).
- The AI service runs LOCALLY on a developer machine with a webcam.
- The Flutter app is built and installed via "flutter run" or APK generation.
- Do NOT invent containerization or cloud-native infrastructure.

ACTUAL DEPLOYMENT ARCHITECTURE:

1. AI Service (Local Machine):
   - camera.py runs on a laptop/desktop with Python 3.10+
   - Requires: USB/WiFi camera connected as webcam
   - Dependencies: ultralytics, opencv-python, torch, numpy, pillow, requests
   - Started manually: "python camera.py"
   - Connects to production backend via HTTPS

2. Django Backend (PythonAnywhere):
   - PythonAnywhere free tier hosting
   - WSGI application (fireguard.wsgi)
   - Static files served via PythonAnywhere static file config
   - Media files (snapshots, avatars, thumbnails) stored on PythonAnywhere filesystem
   - SQLite3 database file (db.sqlite3) on PythonAnywhere
   - URL: https://bodareda0001.pythonanywhere.com
   - Firebase credentials JSON file stored on server (not in VCS)
   - Environment variables loaded from .env file

3. Firebase (Google Cloud — Managed):
   - Firebase project configured for FCM
   - Service account JSON for backend authentication
   - Flutter app configured via flutterfire configure
   - firebase_options.dart generated for Flutter

4. Flutter Mobile App (Android Device):
   - Built via "flutter run" for development
   - APK generated for distribution
   - Requires Firebase configuration
   - Connects to PythonAnywhere backend over HTTPS

INTEGRATION POINTS:
- AI → Backend: HTTPS POST to /api/events/ (AllowAny, multipart form data)
- Mobile → Backend: HTTPS (Dio, Token Authentication)
- Backend → Firebase: Firebase Admin SDK (service account JSON)
- Firebase → Mobile: FCM push notifications

ENVIRONMENT CONFIGURATION (.env.example):
- SECRET_KEY: Django secret key
- DEBUG: True/False
- ALLOWED_HOSTS: list of allowed hosts
- FIREBASE_CREDENTIALS_PATH: path to firebase_credentials.json

DEPLOYMENT TEAM MEMBER: Mostafa Abdo El-Gohary

TERMINOLOGY: AI Camera Node, Edge Node, PythonAnywhere, WSGI

══════════════════════════════════════════════════════════
CHAPTER 8 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Document the deployment strategy, integration of all system components,
environment configuration, and the operational workflow for running FireGuard.

8.1 CHAPTER INTRODUCTION (300–400 words)
   - Overview of the deployment strategy
   - Three-component deployment: local AI, cloud backend, mobile device
   - Chapter roadmap

8.2 DEPLOYMENT ARCHITECTURE (600–800 words)
   - Include a Mermaid deployment diagram showing all components and their
     hosting locations:
     * Local Machine: camera.py + USB Camera
     * PythonAnywhere: Django + SQLite3 + media/
     * Firebase Cloud: FCM
     * User Device: Flutter App
   - Include Table: "Table 8.1: Deployment Targets"
     | Component | Target | Notes |
   - Communication paths and protocols

8.3 BACKEND DEPLOYMENT ON PYTHONANYWHERE (800–1000 words)
   - PythonAnywhere platform overview: free tier, WSGI support, file storage
   - Step-by-step deployment procedure:
     1. Create PythonAnywhere account
     2. Upload project files (git clone or manual upload)
     3. Create virtual environment and install dependencies
     4. Configure WSGI file (fireguard.wsgi)
     5. Set up static files serving
     6. Configure media files directory
     7. Run database migrations
     8. Upload Firebase credentials JSON
     9. Set environment variables
     10. Reload web app
   - Include Table: "Table 8.2: PythonAnywhere Configuration"
     | Setting | Value | Purpose |
   - Static and media file serving configuration
   - HTTPS configuration (PythonAnywhere provides HTTPS by default)

8.4 AI SERVICE SETUP (500–700 words)
   - Local machine requirements: Python 3.10+, webcam, sufficient RAM
   - Installation: pip install -r requirements.txt
   - Model weights: best.pt must be present in ai_service/ directory
   - Camera connection: USB or WiFi camera mapped as webcam (device index 0)
   - Configuration: API_URL pointing to PythonAnywhere backend
   - Running: python camera.py
   - Live monitoring: OpenCV window displays detection feed

8.5 FLUTTER APP BUILD AND INSTALLATION (500–700 words)
   - Flutter SDK setup (3.9+)
   - Firebase configuration: flutterfire configure
   - flutter pub get (dependency installation)
   - Development: flutter run (connected device/emulator)
   - Release build: flutter build apk
   - Include the Firebase configuration checklist

8.6 SYSTEM INTEGRATION (600–800 words)
   - How all three components work together
   - Include a Mermaid sequence diagram showing the end-to-end integrated flow:
     Camera → camera.py → HTTPS POST → PythonAnywhere Django → SQLite3 →
     Firebase Admin SDK → FCM → Flutter App → Alert Screen
   - Running all components simultaneously:
     * Terminal 1: Django backend (or PythonAnywhere)
     * Terminal 2: python camera.py
     * Terminal 3: flutter run (or installed APK)
   - Integration verification checklist

8.7 ENVIRONMENT AND SECURITY CONFIGURATION (400–500 words)
   - .env file configuration
   - Firebase credentials management (not in VCS)
   - SECRET_KEY management
   - ALLOWED_HOSTS configuration
   - CORS settings (development vs. production)

8.8 LIMITATIONS AND FUTURE IMPROVEMENTS (300–400 words)
   - Manual deployment process (no CI/CD)
   - PythonAnywhere free tier limitations (bandwidth, CPU, storage)
   - SQLite3 not suitable for high-concurrency production
   - No HTTPS on local AI service (communicates via HTTPS to PythonAnywhere)
   - No automated backup
   - Future: CI/CD pipeline, PostgreSQL, cloud deployment (AWS/GCP), automated backups

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING: Times New Roman, 12pt body, 16pt chapter title,
14pt sections, 13pt subsections. 1.5 spacing, justified, A4.
Figures: "Figure 8.Y:", Tables: "Table 8.Y:"

ACADEMIC STYLE: Formal third person, IEEE citations.
Do NOT fabricate citations.

REFERENCES (minimum 6 references):
- PythonAnywhere documentation
- Django deployment documentation
- Firebase deployment documentation
- Flutter build documentation
- Software deployment references
- Format: [#] Author(s), "Title," Source, Month Year. DOI/URL.

End with: ## References (IEEE style)

TOKEN OPTIMIZATION: Target 6–8 Word pages.
```

</details>

---

<br/>

---

# 9 — 🧪 Testing & Results Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 9: ~8–10 pages)</b></summary>

```
You are a senior academic engineering writer specializing in software testing,
quality assurance, and system evaluation. You are writing the TESTING & RESULTS
CHAPTER (Chapter 9) for a graduation project book submitted to a university
engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

CRITICAL HONESTY REQUIREMENT:
The project has NO automated test suites (no unit tests, no integration tests,
no CI/CD pipeline). All testing was performed MANUALLY through live demonstrations,
DRF browsable API testing, HTTP client testing, and manual QA on Android devices.
You MUST be honest about this. Do NOT fabricate automated test results.
Explicitly state: "Automated unit and integration tests are not implemented
in the current project version."

ACTUAL TESTING PERFORMED:

1. AI MODEL TESTING (Manual):
   - Model evaluated during training using: Precision, Recall, mAP@0.5, mAP@0.5:0.95
   - Specific metric values from training are NOT stored in the repository
   - Live detection testing scenarios:
     * Fire detection (real flame): ✅ Verified
     * Smoke detection: ✅ Verified
     * No fire/smoke (normal scene): ✅ Verified — no false alerts
     * Cooldown mechanism (two rapid detections within 10s): ✅ First only triggers
     * Snapshot generation: ✅ JPEG with bounding boxes created
     * Low-confidence rejection (<50%): ✅ No alert triggered

2. API ENDPOINT TESTING (Manual via DRF Browsable API + HTTP Clients):
   Authentication:
   - Register new user: 201 ✅ | Duplicate username: 400 ✅ | Duplicate email: 400 ✅
   - Mismatched passwords: 400 ✅ | Valid login: 200+token ✅ | Invalid login: 401 ✅
   - Logout: 200 ✅ | Get profile (auth): 200 ✅ | Get profile (no token): 401 ✅
   - Update profile: 200 ✅ | Change password: 200+new token ✅

   Events:
   - Create event (valid): 201+FCM ✅ | Offline camera: 400 ✅ | Invalid confidence: 400 ✅
   - List events: 200 ✅ | Filter by status: 200 ✅ | Filter by camera: 200 ✅
   - Event detail: 200 ✅ | Resolve: 200 ✅ | False alarm: 200 ✅
   - Active event: 200 ✅ | Stats: 200 ✅

   Cameras & Zones:
   - Create zone (admin): 201 ✅ | Create zone (non-admin): 403 ✅
   - List zones: 200 ✅ | Create camera: 201 ✅
   - Update camera status: 200 ✅ | Camera stats: 200 ✅

   Notifications:
   - Register device: 201 ✅ | Re-register: 200 ✅ | Unregister: 200 ✅
   - Get preferences: 200 ✅ | Update preferences: 200 ✅ | Test push: 200 ✅

3. NOTIFICATION TESTING (Manual):
   - Fire alert (foreground): local notification + stream + alert screen ✅
   - Fire alert (background): system notification with custom sound ✅
   - Fire alert (terminated): notification → tap → alert screen ✅
   - Resolved notification: system notification with message ✅
   - Test push: "FireGuard Test" notification ✅
   - Opt-out user: no notification received ✅
   - Custom alarm sound: fire_alarm plays on Android ✅

4. INTEGRATION TESTING (Manual — Live Demo):
   - Fire detection → notification: AI → Backend → FCM → Flutter ✅
   - Event resolution → notification: Flutter → Backend → FCM → Flutter ✅
   - User registration → auto-profile: register creates User + Profile + Prefs ✅
   - FCM token registration: login triggers token registration ✅
   - Failed token cleanup: invalid tokens marked inactive ✅

5. LIVE DEMO SETUP:
   - Camera: USB camera connected to laptop (WiFi camera as webcam)
   - AI Service: python camera.py on laptop (webcam index 0)
   - Backend: PythonAnywhere (production, remote)
   - Mobile: Flutter app on Android device

6. WHAT WAS NOT TESTED:
   - ❌ No automated unit tests (Django tests.py files are empty)
   - ❌ No automated integration tests
   - ❌ No CI/CD pipeline
   - ❌ No performance/load testing
   - ❌ No cross-platform iOS testing
   - ❌ No security/penetration testing

TERMINOLOGY: FireEvent, Detection Event, Cooldown, Snapshot, AI Camera Node

══════════════════════════════════════════════════════════
CHAPTER 9 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Document all testing activities, present results honestly, analyze system
performance, and acknowledge testing limitations.

9.1 CHAPTER INTRODUCTION (300–400 words)
   - Testing methodology overview: primarily manual verification
   - Honestly acknowledge: no automated test suites
   - Chapter roadmap

9.2 TESTING METHODOLOGY (400–500 words)
   - Testing categories used: manual, live demo, API testing
   - Tools used: DRF Browsable API, Postman/cURL, Django Admin, Android device
   - Include Table: "Table 9.1: Testing Summary"
     | Category | Status | Approach |

9.3 AI MODEL TESTING AND RESULTS (800–1000 words)
   - Model evaluation metrics (from training, use [X] placeholders if not available)
   - Live detection test scenarios table:
     | Scenario | Method | Expected | Result | Status |
   - Include a Mermaid flowchart of the AI testing workflow
   - Detection accuracy discussion
   - Figure placeholders for: detection examples, confusion matrix, accuracy charts

9.4 API ENDPOINT TESTING (1000–1200 words)
   - Complete test case tables for all four endpoint groups:
     | Test Case | Method | Endpoint | Expected Status | Result |
   - Cover ALL tested endpoints from the actual testing data
   - Validation testing: edge cases (offline camera, invalid confidence, etc.)

9.5 NOTIFICATION TESTING (500–700 words)
   - Notification test matrix table:
     | Test | Trigger | Expected | Result |
   - Platform-specific behavior (Android tested, iOS not tested)
   - Custom sound verification

9.6 INTEGRATION TESTING (600–800 words)
   - End-to-end flow testing results
   - Include a Mermaid flowchart of the integration test procedure:
     Start camera.py → Point at fire → Verify detection → Check HTTP 201 →
     Open Flutter app → Verify notification → Verify alert screen →
     Tap Resolve → Verify status updated → Verify resolved notification
   - Integration test scenarios table:
     | Scenario | Components | Expected | Result |

9.7 LIVE DEMONSTRATION (400–500 words)
   - Demo setup description (hardware, software, network)
   - Step-by-step demo procedure
   - Demo results and observations

9.8 RESULTS ANALYSIS AND DISCUSSION (500–700 words)
   - Overall system performance assessment
   - Strengths: real-time detection, end-to-end integration, reliable notifications
   - Weaknesses: single camera, no automated tests, manual deployment
   - Detection reliability discussion
   - Notification latency observations

9.9 TESTING LIMITATIONS (400–500 words)
   - Honestly list ALL testing limitations:
     * No automated unit/integration tests
     * No CI/CD pipeline
     * No performance/load testing
     * No iOS testing
     * No security testing
     * Manual-only process
   - Include Table: "Table 9.X: Testing Limitations"

9.10 RECOMMENDATIONS FOR FUTURE TESTING (300–400 words)
   - Django TestCase classes, DRF APIClient, Flutter widget tests
   - CI/CD with GitHub Actions
   - AI model benchmarking with test datasets
   - Include Table: "Table 9.X: Future Testing Recommendations"
   - Note: "These recommendations are not implemented in the current project version."

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING: Times New Roman, 12pt body, 16pt chapter title,
14pt sections, 13pt subsections. 1.5 spacing, justified, A4.
Figures: "Figure 9.Y:", Tables: "Table 9.Y:"

ACADEMIC STYLE: Formal third person, IEEE citations.
Do NOT fabricate citations. Be HONEST about testing limitations.

REFERENCES (minimum 6 references):
- Software testing textbooks (Myers, Pressman)
- Django testing documentation
- Flutter testing documentation
- Object detection evaluation metrics references
- Format: [#] Author(s), "Title," Source, Month Year. DOI/URL.

End with: ## References (IEEE style)

TOKEN OPTIMIZATION: Target 8–10 Word pages.
```

</details>

---

<br/>

---

# 10 — 🎓 Conclusion & Future Work Chapter

<details>
<summary><b>Click to expand full prompt (Chapter 10: ~5–7 pages)</b></summary>

```
You are a senior academic engineering writer. You are writing the CONCLUSION AND
FUTURE WORK CHAPTER (Chapter 10, the final chapter) for a graduation project book
submitted to a university engineering faculty.

═══════════════════════════════════════════════════════════
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
═══════════════════════════════════════════════════════════

PROJECT SUMMARY:
FireGuard is a graduation project implementing an AI-powered fire and smoke
detection system with real-time mobile notifications. It consists of:
1. AI Camera Node: camera.py + YOLOv8 + OpenCV (local machine with webcam)
2. Backend: Django 5.2 + DRF 3.17 + SQLite3 + Firebase Admin SDK (PythonAnywhere)
3. Mobile App: Flutter 3.9 + Provider + Dio + FCM (Android)

WHAT WAS ACHIEVED:
✅ Real-time fire and smoke detection from a webcam using YOLOv8
✅ Event storage with status lifecycle (active → resolved / false_alarm)
✅ Push notifications via Firebase Cloud Messaging
✅ Mobile app with real-time alert screen and event management
✅ Camera and zone management (CRUD)
✅ User authentication (token-based) and profile management
✅ Notification preferences (per-user opt-in/opt-out)
✅ Backend deployed on PythonAnywhere
✅ Complete API with 20+ endpoints
✅ Manual testing verified all components

WHAT WAS NOT ACHIEVED / NOT IMPLEMENTED:
❌ Multi-camera concurrent processing
❌ Web-based admin dashboard
❌ Video clip recording
❌ CI/CD pipeline
❌ Automated testing (unit, integration)
❌ Role-based access control beyond admin/user
❌ SMS/email alerts
❌ Model retraining pipeline
❌ PostgreSQL migration
❌ iOS testing

TEAM:
- AI: Ali Khaled Abo Raya, Mohamed Abdelfatah Attalah, Mohamed Asaad
- Backend: Abdelrahman Reda Abdellah
- Mobile: Mohamed Hany El-Essawy, Saad Ezzat Saad
- Database: Tarek Mostafa Kashef
- Deployment: Mostafa Abdo El-Gohary

TERMINOLOGY: FireEvent, AI Camera Node, Detection Event, Confidence Threshold,
Active Event, Notification Payload, Edge Node, Inference Pipeline, Cooldown, Snapshot

══════════════════════════════════════════════════════════
CHAPTER 10 STRUCTURE — Generate ALL of the following sections:
══════════════════════════════════════════════════════════

CHAPTER OBJECTIVE:
Summarize the entire project, evaluate achievements against objectives,
discuss challenges faced, and propose concrete future improvements.

10.1 PROJECT SUMMARY (600–800 words)
   - Brief recap of the problem statement (fire detection limitations)
   - Summary of the proposed solution (three-tier architecture)
   - Summary of each component's implementation:
     * AI: YOLOv8 custom-trained model, camera.py with OpenCV, cooldown mechanism
     * Backend: Django REST API with 20+ endpoints, Firebase integration
     * Mobile: Flutter app with Provider state management, alert system, FCM
     * Database: SQLite3 schema with 8 entities, Django ORM
     * Deployment: PythonAnywhere backend, local AI service
   - System workflow recap: Camera → YOLO → API → DB → FCM → Flutter

10.2 OBJECTIVES EVALUATION (500–700 words)
   - Revisit each objective from Chapter 1
   - Include Table: "Table 10.1: Objectives Achievement"
     | # | Objective | Status | Evidence |
   - For each objective: state whether achieved, partially achieved, or not achieved
   - Provide specific evidence (which chapter, which component)

10.3 CHALLENGES AND LESSONS LEARNED (600–800 words)
   - Technical challenges encountered during development:
     * AI: model training, dataset quality, confidence tuning
     * Backend: Firebase integration, token management, API security
     * Mobile: FCM notification handling across app states, state management
     * Database: schema design, migration management
     * Deployment: PythonAnywhere limitations, CORS configuration
     * Integration: end-to-end communication, debugging across components
   - Lessons learned from each challenge
   - Team collaboration challenges and solutions

10.4 LIMITATIONS (400–500 words)
   - Honestly list all project limitations:
     * Single camera support only
     * SQLite3 not suitable for production scale
     * No automated testing
     * Manual deployment
     * Android-only mobile testing
     * AllowAny on event creation endpoint
     * Hardcoded camera ID and API URL in camera.py
     * No video recording (snapshots only)
     * PythonAnywhere free tier constraints
   - Group limitations by category (AI, Backend, Mobile, Deployment)

10.5 FUTURE WORK (800–1000 words)
   - Provide CONCRETE, REALISTIC future improvements organized by priority:
   - Short-term (next iteration):
     * Multi-camera support (parameterized camera.py)
     * API key authentication for AI service
     * Automated unit and integration tests
     * CI/CD pipeline with GitHub Actions
   - Medium-term:
     * PostgreSQL migration for production scalability
     * Web-based admin dashboard
     * Video clip recording around detection events
     * Role-based access control
     * Model retraining pipeline with false alarm feedback
     * SMS/email secondary notification channels
   - Long-term:
     * Multi-site deployment with geo-fencing
     * GPU-accelerated edge inference
     * Cloud deployment (AWS/GCP)
     * Predictive analytics (fire risk scoring)
     * Integration with building management systems
   - Include Table: "Table 10.2: Future Work Roadmap"
     | Priority | Feature | Description | Estimated Effort |

10.6 FINAL REMARKS (200–300 words)
   - Closing statement about the project's contribution
   - Value as a graduation project prototype
   - Potential real-world applicability
   - Acknowledgment of team effort

═══════════════════════════════════════════════════════════
FORMATTING REQUIREMENTS (MANDATORY):
═══════════════════════════════════════════════════════════

DOCUMENT FORMATTING: Times New Roman, 12pt body, 16pt chapter title,
14pt sections, 13pt subsections. 1.5 spacing, justified, A4.
Figures: "Figure 10.Y:", Tables: "Table 10.Y:"

ACADEMIC STYLE: Formal third person, IEEE citations.
Do NOT fabricate citations.

REFERENCES (minimum 4 references):
- Software engineering references (project management, SDLC)
- References to technologies used (for future work justification)
- Format: [#] Author(s), "Title," Source, Month Year. DOI/URL.

End with: ## References (IEEE style)

TOKEN OPTIMIZATION: Target 5–7 Word pages.
```

</details>

---

<br/>

---

## ✅ Cross-Chapter Consistency Checklist

Before submitting each prompt to Claude Sonnet 4.6, verify:

| Check | Description |
|:------|:-----------|
| ☐ Architecture | All chapters describe the SAME three-tier architecture (Edge + Backend + Client) |
| ☐ Technology Stack | Django 5.2, DRF 3.17, SQLite3, YOLOv8, Flutter 3.9, Provider, FCM — no additions |
| ☐ Terminology | All chapters use the same terms from the glossary (FireEvent, AI Camera Node, etc.) |
| ☐ No Hallucinations | No Docker, FastAPI, PostgreSQL, Redis, Kubernetes, CI/CD, microservices |
| ☐ Team Mapping | Each chapter credits the correct team members |
| ☐ Chapter Numbers | Sections use correct chapter prefix (e.g., Chapter 4 uses 4.1, 4.2, Figure 4.1) |
| ☐ References | All citations are real, verifiable, IEEE-formatted |
| ☐ Scope Honesty | Unimplemented features explicitly stated as "Not implemented in the current project version" |
| ☐ Formatting | Times New Roman, 12pt body, 1.5 spacing, justified, A4 |
| ☐ Transitions | Each chapter introduction references the previous chapter's conclusion |

---

## 📝 Post-Generation Workflow

After generating all 10 chapters with Claude Sonnet 4.6:

1. **Merge** all chapters into a single Word document
2. **Verify** cross-chapter terminology consistency
3. **Replace** all `[X]` placeholders with real data
4. **Insert** real screenshots from the `screenshots/` directory
5. **Render** all Mermaid diagrams as images and embed them
6. **Verify** every IEEE reference is real (check DOIs, URLs, authors)
7. **Add** front matter: title page, abstract, acknowledgments, table of contents
8. **Add** back matter: appendices (if needed), full reference list
9. **Format** the complete document with consistent Word styles
10. **Review** with the full team before submission

---

*Generated from the official FireGuard repository documentation.*
*Source of truth: README.md, docs/system_overview.md, docs/architecture.md, docs/ai_pipeline.md, docs/backend.md, docs/mobile_app.md, docs/database.md, docs/testing.md, docs/glossary.md*
