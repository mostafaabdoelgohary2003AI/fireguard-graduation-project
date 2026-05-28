<div align="center">

# 📘 FireGuard — Graduation Book Prompt Library

### Professional Prompt Templates for Claude Sonnet 4.6

<br/>

<img src="https://img.shields.io/badge/Prompts-40%20Sections-blue?style=for-the-badge" alt="40 Sections" />
<img src="https://img.shields.io/badge/Target-Graduation%20Report-green?style=for-the-badge" alt="Graduation Report" />
<img src="https://img.shields.io/badge/AI-Claude%20Sonnet%204.6-purple?style=for-the-badge" alt="Claude" />

<br/><br/>

> **How to use this file:**
> 1. Find the section you need to write
> 2. Copy the prompt inside the code block
> 3. Paste it into Claude Sonnet 4.6
> 4. Review and adapt the generated content to your project specifics
> 5. Add your own data, screenshots, and citations

</div>

<br/>

---

## 📑 Navigation

| # | Section | Category |
|:-:|:---|:---|
| 1 | [Abstract](#1--abstract) | 📄 Front Matter |
| 2 | [Introduction](#2--introduction) | 📄 Front Matter |
| 3 | [Problem Statement](#3--problem-statement) | 📄 Front Matter |
| 4 | [Objectives](#4--objectives) | 📄 Front Matter |
| 5 | [Literature Review](#5--literature-review) | 📚 Background |
| 6 | [Existing Systems Comparison](#6--existing-systems-comparison) | 📚 Background |
| 7 | [System Analysis](#7--system-analysis) | 🔍 Analysis |
| 8 | [Functional Requirements](#8--functional-requirements) | 🔍 Analysis |
| 9 | [Non-functional Requirements](#9--non-functional-requirements) | 🔍 Analysis |
| 10 | [Use Case Analysis](#10--use-case-analysis) | 🔍 Analysis |
| 11 | [Architecture Overview](#11--architecture-overview) | 🏗️ Design |
| 12 | [AI / Computer Vision Chapter](#12--ai--computer-vision-chapter) | 🧠 AI |
| 13 | [Dataset Collection & Annotation](#13--dataset-collection--annotation) | 🧠 AI |
| 14 | [Roboflow Preprocessing Pipeline](#14--roboflow-preprocessing-pipeline) | 🧠 AI |
| 15 | [YOLOv8 Training Methodology](#15--yolov8-training-methodology) | 🧠 AI |
| 16 | [PyTorch Implementation Details](#16--pytorch-implementation-details) | 🧠 AI |
| 17 | [Inference Pipeline](#17--inference-pipeline) | 🧠 AI |
| 18 | [OpenCV Integration](#18--opencv-integration) | 🧠 AI |
| 19 | [Camera Integration Workflow](#19--camera-integration-workflow) | 🧠 AI |
| 20 | [Backend Chapter](#20--backend-chapter) | 🗄️ Backend |
| 21 | [Django REST Framework APIs](#21--django-rest-framework-apis) | 🗄️ Backend |
| 22 | [Authentication & Security](#22--authentication--security) | 🗄️ Backend |
| 23 | [Firebase Notification System](#23--firebase-notification-system) | 🗄️ Backend |
| 24 | [SQLite Database Design](#24--sqlite-database-design) | 🗄️ Backend |
| 25 | [ERD Explanation](#25--erd-explanation) | 🗄️ Backend |
| 26 | [Frontend / Flutter Chapter](#26--frontend--flutter-chapter) | 📱 Frontend |
| 27 | [State Management & Providers](#27--state-management--providers) | 📱 Frontend |
| 28 | [UI/UX Discussion](#28--uiux-discussion) | 📱 Frontend |
| 29 | [Deployment Chapter](#29--deployment-chapter) | 🐳 DevOps |
| 30 | [Docker Architecture](#30--docker-architecture) | 🐳 DevOps |
| 31 | [FastAPI Deployment](#31--fastapi-deployment) | 🐳 DevOps |
| 32 | [Gunicorn Deployment](#32--gunicorn-deployment) | 🐳 DevOps |
| 33 | [Testing & Validation](#33--testing--validation) | ✅ Quality |
| 34 | [Results & Performance Analysis](#34--results--performance-analysis) | 📊 Results |
| 35 | [Challenges & Problems Faced](#35--challenges--problems-faced) | 📊 Results |
| 36 | [Future Work](#36--future-work) | 📊 Results |
| 37 | [Conclusion](#37--conclusion) | 📄 End Matter |
| 38 | [References Formatting](#38--references-formatting) | 📄 End Matter |
| 39 | [Appendix Generation](#39--appendix-generation) | 📄 End Matter |
| 40 | [Presentation / Demo Preparation](#40--presentation--demo-preparation) | 🎤 Defense |

---

<br/>

## 📄 FRONT MATTER

---

### 1 — 📝 Abstract

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer assisting a graduation project team.

Write a professional ABSTRACT for a graduation project report/book with the following specifications:

PROJECT TITLE: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

PROJECT SUMMARY:
- A real-time fire and smoke detection platform using YOLOv8 object detection
- Three-service microservice architecture: FastAPI AI service, Django REST backend, Flutter mobile app
- Push notification alerts via Firebase Cloud Messaging (FCM)
- Containerized deployment using Docker and Docker Compose
- External WiFi camera connected via USB used as webcam input for live detection during demo
- SQLite3 database for data persistence
- Gunicorn production WSGI server for Django

WRITING REQUIREMENTS:
1. Length: 250–350 words (single paragraph or two paragraphs maximum)
2. Tone: Formal academic engineering tone — third person, passive voice preferred
3. Structure the abstract to cover:
   a. Context/motivation (fire hazard statistics, need for early detection)
   b. Problem addressed (limitations of traditional fire detection methods)
   c. Proposed solution (brief system description)
   d. Methodology (YOLOv8 training on custom dataset, Roboflow preprocessing, PyTorch backend)
   e. Key results (detection accuracy, response time, notification latency)
   f. Conclusion statement (system effectiveness and contribution)
4. Include placeholder brackets for specific metrics: [accuracy_%], [response_time_ms], [dataset_size]
5. Do NOT use first person ("we", "our")
6. Do NOT include citations in the abstract
7. End with a sentence about the system's potential for real-world deployment

KEYWORDS (include at end):
Fire Detection, Smoke Detection, YOLOv8, Deep Learning, Real-Time Detection, Flutter, Django, FastAPI, Firebase Cloud Messaging, Docker, Computer Vision, Object Detection

FORMAT: Plain academic text suitable for inclusion in a graduation project book.

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 2 — 📖 Introduction

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer assisting a graduation project team.

Write a comprehensive INTRODUCTION chapter for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

CHAPTER REQUIREMENTS:
Write 1500–2500 words covering the following subsections:

1. BACKGROUND AND CONTEXT
   - Global fire hazard statistics (use placeholder citations: [1], [2], etc.)
   - Economic and human cost of fire incidents
   - Traditional fire detection methods (smoke detectors, heat sensors, sprinkler systems)
   - Limitations of traditional methods (delayed response, false alarms, no visual confirmation)
   - The rise of AI and computer vision in safety systems

2. MOTIVATION
   - Why AI-based fire detection is needed
   - Advantages of visual detection over sensor-based detection
   - The role of real-time alerts in emergency response
   - Mobile-first approach for operator notification

3. PROJECT SCOPE
   - What FireGuard does (detect fire/smoke via camera, alert operators via mobile app)
   - What FireGuard does NOT do (not a fire suppression system, not replacing physical sensors)
   - Target users: building managers, warehouse operators, security personnel

4. TECHNOLOGY JUSTIFICATION
   - Why YOLOv8 (real-time object detection, state-of-the-art accuracy)
   - Why FastAPI (high-performance async Python API)
   - Why Django REST Framework (robust, mature, admin panel, ORM)
   - Why Flutter (cross-platform mobile, single codebase)
   - Why Firebase Cloud Messaging (reliable push delivery)
   - Why Docker (reproducible deployment, microservice isolation)
   - Why SQLite (lightweight, zero-config, suitable for project scale)

5. REPORT ORGANIZATION
   - Brief description of each chapter in the report (Chapter 2: Literature Review, Chapter 3: System Analysis, etc.)

FORMATTING:
- Use numbered subsection headings (1.1, 1.2, 1.3, etc.)
- Include a Mermaid diagram showing the report chapter structure
- Include placeholder citations [1]–[10]
- Include a table comparing traditional vs. AI-based fire detection
- Use formal academic tone, third person
- Add figure caption placeholders: "Figure 1.1: [description]"
- Suggest one infographic: "A timeline of fire detection technology evolution"
```

</details>

---

### 3 — 🎯 Problem Statement

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer assisting a graduation project team.

Write a PROBLEM STATEMENT section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

REQUIREMENTS:
Write 600–1000 words addressing:

1. THE CORE PROBLEM
   - Traditional fire detection systems rely on smoke particles or heat reaching a physical sensor
   - This introduces latency: fire must grow large enough to trigger sensors
   - No visual confirmation — sensors cannot distinguish cooking smoke from fire smoke
   - High false-alarm rates in industrial and residential environments
   - No real-time mobile notification to operators or building managers
   - No centralized monitoring of multiple camera zones

2. SPECIFIC PAIN POINTS
   - Response time gap: between fire start and sensor activation (provide placeholder: [X] seconds average)
   - False alarm cost: unnecessary evacuations cost [Y] per incident
   - Night-time and unattended-area coverage gaps
   - Lack of AI integration in affordable fire detection solutions
   - No automated event logging with visual evidence (snapshots)

3. RESEARCH QUESTIONS
   - Can deep learning models detect fire and smoke from camera feeds in real-time with acceptable accuracy?
   - Can a mobile notification system reduce emergency response time compared to traditional alarms?
   - Can a microservice architecture provide a scalable and deployable fire detection platform?

4. PROBLEM SCOPE BOUNDARIES
   - This project addresses indoor and controlled outdoor environments
   - The system requires camera infrastructure (USB-connected WiFi camera)
   - The system does not replace existing fire suppression systems

FORMATTING:
- Formal academic tone, third person
- Include placeholder citations [1]–[5]
- End with a concise problem statement summary (2–3 sentences, bold)
- Include a table: "Table X: Summary of Identified Problems and Proposed Solutions"
- Suggest an infographic: "Gap analysis between traditional detection and AI-based detection"
```

</details>

---

### 4 — 🎯 Objectives

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer assisting a graduation project team.

Write the PROJECT OBJECTIVES section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

REQUIREMENTS:

1. GENERAL OBJECTIVE (1 paragraph)
   - State the overarching goal of the project in one clear sentence

2. SPECIFIC OBJECTIVES (numbered list, 8–12 items)
   Each objective should be SMART (Specific, Measurable, Achievable, Relevant, Time-bound).
   Cover these areas:
   - Train a YOLOv8 model on a custom fire/smoke dataset with ≥[X]% mAP
   - Build a FastAPI inference service that processes frames in ≤[X] ms
   - Develop a Django REST backend with user authentication, event management, and camera registry
   - Implement Firebase Cloud Messaging for real-time push alerts
   - Develop a Flutter mobile application with full-screen emergency alerts
   - Containerize all services using Docker and Docker Compose
   - Integrate an external WiFi camera as a USB webcam input for live detection
   - Achieve end-to-end detection-to-notification latency of ≤[X] seconds
   - Implement event lifecycle management (active → resolved / false alarm)
   - Create comprehensive API documentation

3. DELIVERABLES TABLE
   Create a table with columns: Deliverable | Description | Status

FORMATTING:
- Formal academic tone
- Use a numbered list for specific objectives
- Include a Mermaid diagram mapping objectives to system components
- Bold the action verb starting each objective ("Design...", "Implement...", "Evaluate...")
- Include placeholder metrics in square brackets
```

</details>

---

<br/>

## 📚 BACKGROUND

---

### 5 — 📖 Literature Review

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with expertise in computer vision and fire safety systems.

Write a comprehensive LITERATURE REVIEW chapter for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

CHAPTER REQUIREMENTS:
Write 3000–5000 words covering the following subsections:

1. FIRE DETECTION TECHNOLOGIES — HISTORICAL OVERVIEW
   - Ionization smoke detectors (1960s–present)
   - Photoelectric smoke detectors
   - Heat detectors and rate-of-rise sensors
   - Flame detectors (UV/IR)
   - Multi-sensor fusion approaches
   - Include a timeline table of fire detection technology milestones

2. COMPUTER VISION IN FIRE DETECTION
   - Early approaches: color-based segmentation (HSV thresholding)
   - Motion-based detection (optical flow, frame differencing)
   - Handcrafted feature extraction (HOG, LBP, Haar-like features)
   - Transition to deep learning (2012–present)
   - CNN-based approaches: AlexNet, VGG, ResNet for fire classification
   - Include a comparison table of traditional CV vs. deep learning approaches

3. OBJECT DETECTION MODELS
   - Two-stage detectors: R-CNN, Fast R-CNN, Faster R-CNN
   - Single-stage detectors: SSD, YOLO family (v1 through v8)
   - Transformer-based: DETR, RT-DETR
   - Why YOLO is preferred for real-time applications
   - Include a table comparing YOLO versions (v3, v5, v7, v8) on speed, mAP, and parameters

4. YOLOv8 ARCHITECTURE DEEP DIVE
   - Backbone: CSPDarknet with C2f modules
   - Neck: PAN-FPN (Path Aggregation Network + Feature Pyramid Network)
   - Head: Decoupled anchor-free detection head
   - Loss functions: CIoU loss, DFL loss, BCE loss
   - Include a Mermaid diagram of YOLOv8 architecture (backbone → neck → head)

5. DATASET ANNOTATION AND PREPROCESSING
   - Common fire/smoke datasets in literature (FIRESENSE, BoWFire, Foggia, D-Fire)
   - Annotation formats: PASCAL VOC, COCO, YOLO format
   - Data augmentation techniques for fire detection
   - Role of Roboflow in modern ML pipelines
   - Include a table of public fire/smoke datasets with size, classes, and format

6. MOBILE AND IOT FIRE DETECTION SYSTEMS
   - Edge AI approaches (TensorFlow Lite, ONNX Runtime on mobile)
   - Cloud-based inference architectures
   - Push notification systems in safety applications
   - Flutter and cross-platform mobile development for IoT monitoring

7. MICROSERVICE ARCHITECTURES FOR AI SYSTEMS
   - Monolithic vs. microservice architectures
   - FastAPI as an inference serving framework
   - Django REST Framework for business logic APIs
   - Docker containerization for ML deployment
   - Include a comparison table: monolithic vs. microservice for AI systems

8. RESEARCH GAP IDENTIFICATION
   - Summarize what existing systems lack
   - Position FireGuard's contribution:
     * End-to-end pipeline (detection → notification → resolution)
     * Mobile-first operator interface
     * Microservice architecture with independent scaling
     * Open-source, affordable, and deployable

FORMATTING:
- Formal academic tone, third person, past tense for reviewed work
- Include placeholder citations [1]–[30] distributed throughout
- Include at least 4 comparison tables
- Include at least 2 Mermaid diagrams
- Include figure caption placeholders
- End with a "Summary of Literature Review" subsection (1 paragraph)
- Suggest infographic: "Evolution of fire detection: from smoke sensors to AI vision"

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 6 — 📊 Existing Systems Comparison

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in system comparison analysis.

Write an EXISTING SYSTEMS COMPARISON section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

REQUIREMENTS:
Write 1000–1500 words covering:

1. SELECTED EXISTING SYSTEMS (research and compare at least 5):
   - DeepFire / FireNet (academic CNN-based fire detection)
   - Nest Protect (commercial smart smoke detector by Google)
   - Hikvision Smart Fire Detection (commercial IP camera solution)
   - Amazon Rekognition Custom Labels (cloud-based detection)
   - Open-source fire detection projects on GitHub (e.g., fire-detection-cnn)
   - Any other relevant systems from recent literature

2. COMPARISON CRITERIA:
   Create a comprehensive comparison table with these columns:
   | Criterion | System 1 | System 2 | ... | FireGuard |
   
   Criteria to compare:
   - Detection method (sensor / CNN / YOLO / cloud API)
   - Real-time capability (Yes/No, latency)
   - Mobile app support
   - Push notification support
   - Open source (Yes/No)
   - Cost (Free / Subscription / Hardware cost)
   - Deployment method (Cloud / Edge / On-premise / Docker)
   - Multi-camera support
   - Event lifecycle management
   - Database and logging
   - Accuracy reported (mAP or other metric)
   - Custom training support

3. ANALYSIS
   - Strengths and weaknesses of each system
   - What FireGuard offers that others don't
   - Unique selling points of FireGuard

4. POSITIONING STATEMENT
   - 1 paragraph explaining where FireGuard fits in the landscape

FORMATTING:
- Formal academic tone
- Include the large comparison table
- Include placeholder citations
- Include a radar chart suggestion comparing FireGuard vs. top 2 competitors
- Include figure/table captions

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

<br/>

## 🔍 ANALYSIS

---

### 7 — 🔍 System Analysis

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in software systems analysis.

Write a SYSTEM ANALYSIS chapter for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

SYSTEM CONTEXT:
- Three-service microservice architecture
- AI Service: FastAPI + YOLOv8 + Ultralytics + OpenCV (port 8001)
- Backend: Django 5.2 + DRF 3.17 + Gunicorn + SQLite3 (port 8000)
- Frontend: Flutter 3.9+ mobile app (Android/iOS)
- External services: Firebase Cloud Messaging
- External hardware: USB-connected WiFi camera as webcam input
- Deployment: Docker Compose with bridge network
- Demo workflow: camera.py captures frames → AI service detects → backend stores → FCM notifies → Flutter alerts

CHAPTER REQUIREMENTS (2000–3000 words):

1. SYSTEM OVERVIEW
   - High-level description of the system and its purpose
   - Stakeholders: building operators, security teams, system administrators
   - System boundaries: what is inside vs. outside the system

2. FEASIBILITY STUDY
   - Technical feasibility (Python, Flutter, Docker — all mature technologies)
   - Economic feasibility (open-source stack, no licensing costs)
   - Operational feasibility (minimal training required, intuitive mobile UI)
   - Schedule feasibility (development timeline)
   - Include a feasibility summary table

3. SYSTEM CONTEXT DIAGRAM
   - Provide a Mermaid diagram showing the system boundary with external actors:
     * Camera hardware
     * Firebase Cloud Messaging
     * Mobile device (operator)
     * System administrator
   - Describe each external entity and its interaction with the system

4. DATA FLOW ANALYSIS
   - Level 0 DFD (context diagram) — describe in text, suggest Mermaid
   - Level 1 DFD — show data flows between AI service, backend, database, FCM, mobile app
   - Describe each data flow: image frames, detection results, events, notifications, user actions

5. PROCESS ANALYSIS
   - Detection process (frame capture → inference → threshold check → backend notification)
   - Event lifecycle (active → resolved / false_alarm)
   - User authentication flow (register → login → token → API access)
   - Notification delivery flow (event created → FCM multicast → mobile alert → operator action)

FORMATTING:
- Include at least 3 Mermaid diagrams (context, DFD Level 1, process flow)
- Include tables for feasibility analysis
- Formal academic tone, third person
- Include figure/table caption placeholders
- Placeholder citations where relevant
IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 8 — ✅ Functional Requirements

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in software requirements engineering.

Write the FUNCTIONAL REQUIREMENTS section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

SYSTEM MODULES:
1. AI Service (FastAPI + YOLOv8)
2. Backend (Django REST Framework)
3. Mobile App (Flutter)
4. Notification Service (Firebase Cloud Messaging)

REQUIREMENTS:
Generate a comprehensive list of functional requirements organized by module. For each requirement:
- Assign an ID (FR-AI-001, FR-BE-001, FR-FE-001, FR-NT-001)
- Write a clear "The system shall..." statement
- Assign a priority (Must Have / Should Have / Could Have — MoSCoW method)
- Assign a module

Cover at minimum:
AI SERVICE:
- Accept image upload via POST /predict
- Run YOLOv8 inference on uploaded image
- Return detection results (event_type, confidence, bounding boxes)
- Auto-notify Django backend when confidence > 50%
- Provide health check endpoint
- Support configurable confidence threshold

BACKEND:
- User registration and login (token authentication)
- CRUD operations for cameras and zones
- CRUD operations for fire events
- Event resolution and false alarm marking
- FCM device registration and unregistration
- Notification preferences management
- Statistics endpoints (event counts, camera stats)
- Admin panel access

MOBILE APP:
- Splash screen with auto-login check
- Login and registration screens
- Home dashboard with system status
- Camera management (list, add, delete)
- Real-time push notification reception
- Full-screen emergency alert with siren and vibration
- Notification history with filtering
- Settings and profile management
- Simulate alert for testing/demo

NOTIFICATION SERVICE:
- Register device FCM token
- Send multicast fire/smoke alerts
- Send event resolved notifications
- Respect user notification preferences
- Test push endpoint

FORMAT:
- Present as a large table: ID | Description | Priority | Module
- Group by module with module headers
- Include at least 30 functional requirements total
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 9 — 📋 Non-functional Requirements

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in software requirements engineering.

Write the NON-FUNCTIONAL REQUIREMENTS section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

Generate non-functional requirements covering these quality attributes:

1. PERFORMANCE
   - AI inference latency: ≤[X] ms per frame on [hardware_spec]
   - API response time: ≤[X] ms for REST endpoints
   - End-to-end detection-to-notification latency: ≤[X] seconds
   - Support for concurrent API requests

2. RELIABILITY
   - System uptime target: [X]%
   - Graceful degradation if Firebase is unavailable
   - Health check monitoring for all services
   - Auto-restart on failure (Docker restart: always)

3. SCALABILITY
   - Independent service scaling via Docker
   - Gunicorn worker configuration for concurrent requests
   - Database connection pooling considerations

4. SECURITY
   - Token-based authentication (DRF TokenAuthentication)
   - CORS configuration
   - Firebase service account credential management
   - No plaintext passwords stored
   - HTTPS recommended for production

5. USABILITY
   - Mobile app intuitive enough for non-technical operators
   - Full-screen alerts with audio/visual/haptic feedback
   - Responsive UI using flutter_screenutil

6. MAINTAINABILITY
   - Modular microservice architecture
   - Feature-first Flutter directory structure
   - Django apps organized by domain (accounts, cameras, events, notifications)
   - Docker Compose for reproducible environments

7. PORTABILITY
   - Cross-platform mobile app (Android + iOS from single Flutter codebase)
   - Docker containers run on any Linux/Mac/Windows host
   - SQLite requires no external database server

8. COMPATIBILITY
   - Android 6.0+ and iOS 12+
   - Python 3.10+
   - Docker Engine 20+

FORMAT:
- Present as a table: ID | Category | Description | Target Metric
- Use IDs: NFR-PERF-001, NFR-REL-001, NFR-SEC-001, etc.
- Include at least 20 non-functional requirements
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 10 — 👥 Use Case Analysis

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in UML analysis and software design.

Write a USE CASE ANALYSIS section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

ACTORS:
- Operator (mobile app user — building manager / security personnel)
- Administrator (Django admin panel user)
- AI Service (automated actor — detects fire/smoke)
- Camera (hardware actor — captures frames)
- Firebase (external service — delivers push notifications)

REQUIREMENTS:

1. USE CASE DIAGRAM
   - Provide a Mermaid diagram showing all actors and their use cases
   - Group use cases by subsystem (AI, Backend, Mobile)

2. USE CASE DESCRIPTIONS (detailed format for at least 8 use cases):
   For each use case, provide:
   - Use Case ID: UC-001
   - Use Case Name
   - Primary Actor
   - Preconditions
   - Main Success Scenario (numbered steps)
   - Alternative Flows
   - Postconditions
   - Related Requirements (link to FR IDs)

   Cover these use cases at minimum:
   a. Register New Account
   b. Login to System
   c. View Home Dashboard
   d. Add New Camera
   e. Detect Fire/Smoke (AI automated)
   f. Receive Emergency Alert
   g. Resolve Fire Event
   h. Mark Event as False Alarm
   i. View Notification History
   j. Manage Notification Preferences

3. USE CASE RELATIONSHIPS
   - Identify <<include>> and <<extend>> relationships
   - Example: "Receive Emergency Alert" <<include>> "Send FCM Notification"
   - Example: "Detect Fire/Smoke" <<extend>> "Save Event Snapshot"

4. ACTOR-USE CASE MATRIX
   - Create a table: rows = use cases, columns = actors
   - Mark with ✓ which actor participates in which use case

FORMATTING:
- Include Mermaid use case diagram
- Include a Mermaid sequence diagram for the "Detect Fire → Alert Operator" scenario
- Include detailed use case description tables
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

<br/>

## 🏗️ DESIGN

---

### 11 — 🏗️ Architecture Overview

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in software architecture.

Write the ARCHITECTURE OVERVIEW chapter for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

ARCHITECTURE DETAILS:
- Microservice architecture with 3 independent services
- AI Service: FastAPI (Python 3.10) + YOLOv8 + Uvicorn — port 8001
- Backend: Django 5.2 + DRF 3.17 + Gunicorn (3 workers) — port 8000
- Frontend: Flutter 3.9+ / Dart ^3.9 (Provider state management, Dio HTTP, go_router navigation)
- Database: SQLite3 (inside backend container)
- External: Firebase Cloud Messaging for push notifications
- Networking: Docker bridge network (app_network) — services communicate via container DNS
- Hardware: External WiFi camera connected through USB port, used as webcam input

CHAPTER REQUIREMENTS (2000–3000 words):

1. ARCHITECTURAL STYLE JUSTIFICATION
   - Why microservices over monolithic
   - Service independence and deployment isolation
   - Technology heterogeneity (FastAPI for AI, Django for business logic, Flutter for mobile)

2. HIGH-LEVEL ARCHITECTURE DIAGRAM
   - Provide a Mermaid diagram showing:
     * Camera → AI Service → Backend → Database
     * Backend → Firebase → Flutter App
     * Docker network boundary
   - Label all communication protocols (HTTP REST, FCM push)

3. COMPONENT DESCRIPTIONS
   For each service, describe:
   - Responsibility
   - Technology stack
   - Exposed interfaces (APIs, ports)
   - Dependencies on other services

4. COMMUNICATION PATTERNS
   - Synchronous REST (AI Service → Backend event creation)
   - Asynchronous push (Backend → FCM → Flutter)
   - Request-response (Flutter → Backend CRUD operations)
   - Include a table of all inter-service communication flows

5. DATA ARCHITECTURE
   - Data storage strategy (SQLite for relational data, filesystem for snapshots)
   - Data flow: from camera frame to stored event to mobile notification
   - Include a Mermaid sequence diagram for the full detection lifecycle

6. DEPLOYMENT ARCHITECTURE
   - Docker Compose service topology
   - Container networking
   - Port mappings
   - Volume management
   - Health check strategy

7. DESIGN PATTERNS USED
   - Repository pattern (Django ORM)
   - Provider pattern (Flutter state management)
   - Factory pattern (YOLO model loading)
   - Observer pattern (FCM push notifications)
   - Dependency injection (Django settings, environment variables)

FORMATTING:
- Include at least 3 Mermaid diagrams (system architecture, sequence diagram, deployment)
- Include tables for communication flows and design patterns
- Formal academic engineering tone
- Figure/table caption placeholders
- Placeholder citations where relevant

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

<br/>

## 🧠 AI / COMPUTER VISION

---

### 12 — 🧠 AI / Computer Vision Chapter

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with deep expertise in deep learning and computer vision.

Write the AI / COMPUTER VISION CHAPTER introduction for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

This chapter introduction should:

1. OVERVIEW (500–800 words)
   - Introduce the AI component's role within the FireGuard system
   - Explain why computer vision was chosen over traditional sensors
   - Describe the end-to-end AI pipeline at a high level:
     Camera → Frame capture → Preprocessing → YOLOv8 Inference → Post-processing → Event decision → Backend notification
   - Position this as the "brain" of the system

2. AI PIPELINE ARCHITECTURE DIAGRAM
   - Provide a Mermaid flowchart showing the complete AI pipeline:
     Image Input → OpenCV Decode → Color Conversion (BGR→RGB) → YOLOv8 Inference → NMS → Filter Target Classes (fire, smoke) → Confidence Check → Threshold Decision → Notify Backend / Return "none"

3. KEY DESIGN DECISIONS TABLE
   | Decision | Options Considered | Chosen | Justification |
   Examples:
   - Model architecture: YOLOv8 vs. YOLOv5 vs. Faster R-CNN vs. SSD
   - Input size: 640×640 vs. 416×416 vs. 1280×1280
   - Confidence threshold: 0.5 — balancing precision and recall
   - Target classes: fire, smoke (2 classes)
   - Preprocessing: Roboflow automated pipeline vs. manual augmentation

4. CHAPTER ROADMAP
   - Brief description of the subsections that follow (dataset, Roboflow, training, inference, OpenCV, camera)

FORMATTING:
- Formal academic tone
- Include Mermaid pipeline diagram
- Include design decisions table
- Figure/table caption placeholders
- Placeholder citations [1]–[5]

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 13 — 📦 Dataset Collection & Annotation

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with expertise in machine learning datasets.

Write the DATASET COLLECTION AND ANNOTATION section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

DATASET CONTEXT:
- The project uses a custom fire and smoke detection dataset
- Dataset was managed and preprocessed via Roboflow
- Annotations are in YOLO format (class_id center_x center_y width height)
- Two target classes: fire (0), smoke (1)
- The dataset includes images from various sources (internet, custom captures, public datasets)

SECTION REQUIREMENTS (1500–2000 words):

1. DATA COLLECTION STRATEGY
   - Sources of images (public datasets, web scraping, custom captures)
   - Diversity considerations (indoor, outdoor, day, night, different fire types)
   - Negative samples (non-fire images for reducing false positives)
   - Include a table: "Table X: Dataset Sources" with columns: Source | Type | Image Count | Notes

2. ANNOTATION METHODOLOGY
   - Annotation tool used (Roboflow annotation interface)
   - Annotation format: YOLO format explanation
   - Annotation guidelines (bounding box around visible fire/smoke region)
   - Quality control measures (double-checking, filtering bad annotations)
   - Include an example annotation file with explanation
   - Include a figure suggestion: "Figure X: Sample annotated images showing fire and smoke bounding boxes"

3. DATASET STATISTICS
   - Total images: [X]
   - Training/Validation/Test split: [X]%/[X]%/[X]%
   - Class distribution: fire [X] instances, smoke [X] instances
   - Include a bar chart suggestion showing class distribution
   - Include a table: "Table X: Dataset Split Summary"

4. DATASET CHALLENGES
   - Class imbalance handling
   - Ambiguous cases (steam vs. smoke, sunset glow vs. fire)
   - Small object detection challenges
   - Varying image resolutions and aspect ratios

5. ANNOTATION FORMAT SPECIFICATION
   - YOLO format detailed explanation with mathematical formulation
   - Conversion from pixel coordinates to normalized coordinates
   - Include the formula: center_x = (x_min + x_max) / (2 * image_width)

FORMATTING:
- Formal academic tone
- Include dataset statistics tables
- Include figure placeholders for sample annotated images
- Include annotation format examples in code blocks
- Placeholder citations

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 14 — 🔄 Roboflow Preprocessing Pipeline

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with expertise in ML data pipelines.

Write the ROBOFLOW PREPROCESSING PIPELINE section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

SECTION REQUIREMENTS (1000–1500 words):

1. INTRODUCTION TO ROBOFLOW
   - What is Roboflow and its role in the ML pipeline
   - Why Roboflow was chosen (web-based, easy annotation, auto-augmentation, export to YOLO format)
   - Alternative tools considered (LabelImg, CVAT, Labelme) — comparison table

2. PREPROCESSING STEPS
   Describe each preprocessing step applied:
   a. Auto-Orient: Correct EXIF orientation
   b. Resize: to [X]×[X] pixels (stretch/letterbox/crop)
   c. Grayscale conversion (if applied) or color preservation
   d. Normalization strategy
   e. Tile generation (if applied for small object detection)
   - Include a Mermaid flowchart: Raw Images → Upload → Annotate → Preprocess → Augment → Export

3. DATA AUGMENTATION TECHNIQUES
   For each augmentation, describe what it does and why it helps:
   - Horizontal flip (simulate different camera angles)
   - Random rotation (±15°) (handle tilted cameras)
   - Brightness adjustment (±25%) (day/night variation)
   - Blur (up to 2px) (simulate camera motion)
   - Noise injection (simulate low-quality cameras)
   - Mosaic augmentation (if used — standard in YOLOv8 training)
   - Include a table: "Table X: Augmentation Techniques Applied"
   - Include a figure suggestion: "Figure X: Before and after augmentation examples"

4. DATASET VERSIONING
   - How Roboflow handles dataset versions
   - Version used for final training: v[X]
   - Changes between versions (if any)

5. EXPORT FORMAT
   - Export to YOLOv8 PyTorch format
   - Directory structure: train/images, train/labels, valid/images, valid/labels, test/images, test/labels
   - data.yaml file explanation

FORMATTING:
- Formal academic tone
- Include Mermaid pipeline flowchart
- Include augmentation comparison table
- Include figure placeholders
- Placeholder citations

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 15 — 🏋️ YOLOv8 Training Methodology

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with deep expertise in training deep learning object detection models.

Write the YOLOv8 TRAINING METHODOLOGY section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

TRAINING CONTEXT:
- Model: YOLOv8 (Ultralytics implementation)
- Framework: PyTorch
- Classes: fire, smoke (2 classes)
- Dataset prepared via Roboflow, exported in YOLOv8 format
- Trained weights saved as best.pt

SECTION REQUIREMENTS (2000–2500 words):

1. MODEL SELECTION
   - YOLOv8 variant selection (nano/small/medium/large/xlarge)
   - Trade-off analysis: accuracy vs. speed vs. model size
   - Include a table comparing YOLOv8 variants (parameters, FLOPs, mAP on COCO)
   - Justify the chosen variant for this project

2. TRAINING CONFIGURATION
   - Hyperparameters table:
     | Parameter | Value | Justification |
     - Epochs: [X]
     - Batch size: [X]
     - Image size: 640
     - Learning rate: [X]
     - Optimizer: SGD / AdamW
     - Weight decay: [X]
     - Momentum: [X]
     - Warmup epochs: [X]
     - Augmentation: mosaic, hsv_h, hsv_s, hsv_v, translate, scale, fliplr
   - Pre-trained weights: COCO pre-trained (transfer learning)

3. TRANSFER LEARNING STRATEGY
   - Explain transfer learning concept
   - Why start from COCO pre-trained weights
   - Fine-tuning approach (freeze backbone initially or train end-to-end)
   - Benefits for small custom datasets

4. TRAINING PROCESS
   - Hardware used (GPU model, VRAM, training time)
   - Training command example:
     ```python
     from ultralytics import YOLO
     model = YOLO('yolov8s.pt')
     model.train(data='data.yaml', epochs=100, imgsz=640, batch=16)
     ```
   - Training monitoring (loss curves, mAP progression)
   - Early stopping criteria
   - Include figure suggestions: "Figure X: Training loss curve", "Figure X: mAP@0.5 over epochs"

5. LOSS FUNCTIONS
   - Box loss (CIoU — Complete Intersection over Union)
   - Classification loss (Binary Cross-Entropy)
   - Distribution Focal Loss (DFL) for box regression
   - Include mathematical formulas for each loss

6. EVALUATION METRICS
   - Precision, Recall, F1-Score — define each with formula
   - mAP@0.5 (mean Average Precision at IoU threshold 0.5)
   - mAP@0.5:0.95 (COCO-style metric)
   - Confusion matrix description
   - Include a table: "Table X: Training Results Summary"
   - Include figure suggestions: PR curve, confusion matrix, F1-confidence curve

7. MODEL EXPORT
   - Best weights selection (best.pt vs. last.pt)
   - Model size on disk
   - Inference speed benchmarks

FORMATTING:
- Formal academic tone
- Include at least 3 tables (variants, hyperparameters, results)
- Include mathematical formulas for metrics and losses
- Include code block examples
- Include figure placeholders for all training curves
- Placeholder citations

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 16 — 🔧 PyTorch Implementation Details

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with expertise in PyTorch and deep learning frameworks.

Write the PYTORCH IMPLEMENTATION DETAILS section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

CONTEXT:
- YOLOv8 is built on top of PyTorch via the Ultralytics library
- The AI service uses PyTorch as the inference runtime
- Model file: best.pt (serialized PyTorch model)

SECTION REQUIREMENTS (1000–1500 words):

1. PYTORCH FRAMEWORK OVERVIEW
   - What PyTorch is and its role in the ML ecosystem
   - Dynamic computation graphs vs. static (TensorFlow comparison)
   - Why PyTorch is the default backend for Ultralytics YOLOv8
   - Include a comparison table: PyTorch vs. TensorFlow for object detection

2. ULTRALYTICS LIBRARY INTEGRATION
   - How Ultralytics wraps PyTorch for YOLOv8
   - The YOLO class API: load, train, predict, export
   - Model serialization format (.pt files — PyTorch's torch.save)
   - Include code examples showing key API calls

3. INFERENCE RUNTIME
   - Model loading: torch.load() under the hood
   - GPU vs. CPU inference (torch.device selection)
   - Tensor operations during inference
   - Non-Maximum Suppression (NMS) post-processing
   - Memory management considerations

4. CUSTOM MODEL INTEGRATION
   - How best.pt is loaded in the FireGuard AI service
   - Model warmup strategy (dummy inference on startup)
   - Thread safety considerations for concurrent requests
   - Include a code snippet from model.py showing the load + warmup

FORMATTING:
- Formal academic tone
- Include code snippets with syntax highlighting
- Include framework comparison table
- Figure/table caption placeholders
- Placeholder citations

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 17 — ⚡ Inference Pipeline

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with expertise in ML inference systems.

Write the INFERENCE PIPELINE section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

INFERENCE CONTEXT:
- Client sends image frame via HTTP POST to /predict endpoint
- FastAPI receives the multipart upload
- Image is decoded using OpenCV (numpy array)
- Color conversion BGR → RGB
- YOLOv8 model runs inference
- Results filtered to target classes: {fire, smoke}
- Confidence threshold: 0.5 (50%)
- If detection confidence > 50%, AI service auto-notifies Django backend via POST /api/events/
- Response returned to client: {event_type, confidence, detections[]}

SECTION REQUIREMENTS (1500–2000 words):

1. PIPELINE OVERVIEW
   - End-to-end flow description
   - Include a Mermaid flowchart:
     HTTP POST /predict → Validate Content-Type → Read Bytes → Decode Image (OpenCV) → BGR→RGB → YOLO Inference → Filter Target Classes → Confidence Check → Return Result + Optionally Notify Backend

2. STEP-BY-STEP BREAKDOWN
   For each step, describe:
   a. Image reception and validation (FastAPI UploadFile)
   b. Image decoding (numpy.frombuffer → cv2.imdecode → cv2.cvtColor)
   c. Model inference (model(image, conf=0.5, verbose=False))
   d. Result parsing (iterate results, extract boxes, labels, confidence)
   e. Target class filtering (only fire and smoke)
   f. Best detection selection (highest confidence among detections)
   g. Threshold decision (confidence > 50% → notify backend)
   h. Backend notification (HTTP POST with camera_id, event_type, ai_confidence)
   i. Response construction (JSON with event_type, confidence, detections array)

3. CODE WALKTHROUGH
   - Include annotated code snippets from:
     * main.py predict() endpoint
     * inference.py FireDetector class
     * model.py run_inference() function
   - Explain each function's role

4. ERROR HANDLING
   - Invalid image format
   - Empty image data
   - Model loading failure
   - Backend notification failure (graceful degradation)

5. PERFORMANCE CHARACTERISTICS
   - Inference time per frame: [X] ms
   - Include a table: "Table X: Inference Pipeline Timing Breakdown"
     | Step | Average Time (ms) |
     | Image decode | [X] |
     | Color conversion | [X] |
     | YOLO inference | [X] |
     | Post-processing | [X] |
     | Total | [X] |

FORMATTING:
- Include Mermaid pipeline flowchart
- Include annotated code snippets
- Include timing breakdown table
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 18 — 📷 OpenCV Integration

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer with expertise in computer vision and image processing.

Write the OPENCV INTEGRATION section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

OPENCV USAGE IN THE PROJECT:
1. AI Service (inference.py): Image decoding from bytes, color conversion (BGR→RGB)
2. camera.py: Webcam capture (cv2.VideoCapture), frame reading, detection visualization, image display
3. webcam_client.py: Webcam capture and frame streaming to AI service

SECTION REQUIREMENTS (1000–1500 words):

1. OPENCV OVERVIEW
   - What is OpenCV and its role in computer vision
   - Why opencv-python-headless was chosen for the server (no GUI dependencies)
   - Version used and compatibility considerations

2. IMAGE PROCESSING PIPELINE
   - Byte array to numpy array: np.frombuffer(image_bytes, dtype=np.uint8)
   - Image decoding: cv2.imdecode(buffer, cv2.IMREAD_COLOR)
   - Color space conversion: cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
   - Why BGR→RGB conversion is necessary (OpenCV loads as BGR, YOLO expects RGB)

3. WEBCAM INTEGRATION
   - cv2.VideoCapture(0) for USB camera access
   - Frame reading loop: cap.read()
   - Frame encoding for HTTP transmission: cv2.imencode('.jpg', frame)
   - Live visualization: cv2.imshow() with detection overlays

4. DETECTION VISUALIZATION
   - Bounding box drawing: result.plot() (Ultralytics built-in)
   - Custom overlay rendering for the demo
   - Snapshot saving: cv2.imwrite() for event snapshots

FORMATTING:
- Include code snippets for each OpenCV operation
- Include a Mermaid diagram showing the image processing flow
- Formal academic tone
- Figure placeholders for sample processed images

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

### 19 — 📹 Camera Integration Workflow

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in IoT and hardware integration.

Write the CAMERA INTEGRATION WORKFLOW section for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

HARDWARE CONTEXT:
- External WiFi camera connected through USB port to the host machine
- The camera appears as a standard webcam device (video device index 0)
- OpenCV's VideoCapture(0) accesses the camera feed
- Two integration modes:
  1. Direct mode (camera.py): Runs YOLO locally, posts events directly to Django backend
  2. Client mode (webcam_client.py): Captures frames, sends to AI service via HTTP for inference

SECTION REQUIREMENTS (1000–1500 words):

1. HARDWARE SETUP
   - WiFi camera specifications (placeholder for actual model)
   - USB connection method and driver requirements
   - Device enumeration (how the OS recognizes it as webcam)
   - Include a diagram suggestion: "Figure X: Hardware connection diagram"

2. INTEGRATION MODE 1: DIRECT DETECTION (camera.py)
   - Camera opens via cv2.VideoCapture(0)
   - YOLO model loaded locally (best.pt)
   - Frame-by-frame inference loop
   - Cooldown mechanism (10-second gap between alerts to prevent flooding)
   - Alert includes snapshot image uploaded to Django backend
   - Live visualization window for demo/discussion
   - Include a Mermaid sequence diagram

3. INTEGRATION MODE 2: CLIENT-SERVER (webcam_client.py)
   - Camera opens via cv2.VideoCapture(0)
   - Frames captured every 2 seconds
   - Frame encoded as JPEG and sent via HTTP POST to AI service /predict
   - AI service handles inference and backend notification
   - Client displays results in terminal
   - Include a Mermaid sequence diagram

4. DEMO WORKFLOW
   - How the system is demonstrated during the graduation discussion
   - Setup steps: connect camera → start Docker services → run camera.py
   - Expected behavior: fire/smoke in front of camera → detection → mobile alert
   - Fallback: demo.py for simulated detection without physical camera

5. CHALLENGES AND SOLUTIONS
   - Camera driver compatibility across operating systems
   - Frame rate optimization
   - Network latency between camera client and AI service
   - USB bandwidth considerations

FORMATTING:
- Include Mermaid sequence diagrams for both modes
- Include hardware connection diagram suggestion
- Include a comparison table of the two integration modes
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---

<br/>

## 🗄️ BACKEND

---

### 20 — 🗄️ Backend Chapter

<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in backend development and web APIs.

Write the BACKEND CHAPTER introduction for a graduation project report/book.

PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System

BACKEND DETAILS:
- Framework: Django 5.2 + Django REST Framework 3.17
- Server: Gunicorn 21.2 (3 workers)
- Database: SQLite3
- Authentication: DRF Token Authentication
- Firebase: firebase-admin SDK for push notifications
- Django apps: accounts, cameras, events, notifications
- Deployment: Docker (python:3.10-slim)
- Environment: python-dotenv for .env loading
- CORS: django-cors-headers (CORS_ALLOW_ALL_ORIGINS = True for development)

SECTION REQUIREMENTS (800–1200 words):

1. BACKEND ROLE IN THE SYSTEM
   - Central business logic and data persistence layer
   - API gateway for the Flutter mobile app
   - Event receiver from the AI service
   - Notification dispatcher via Firebase Cloud Messaging

2. TECHNOLOGY JUSTIFICATION TABLE
   | Technology | Version | Purpose | Why Chosen |
   - Django, DRF, Gunicorn, SQLite, firebase-admin, python-dotenv, django-cors-headers

3. DJANGO PROJECT STRUCTURE
   - fireguard/ (project package): settings.py, urls.py, firebase.py, wsgi.py
   - accounts/ (user management)
   - cameras/ (infrastructure registry)
   - events/ (detection lifecycle)
   - notifications/ (FCM dispatch)
   - Include a Mermaid diagram showing the Django app structure and their relationships

4. CHAPTER ROADMAP
   - List the subsections that follow

FORMATTING:
- Formal academic tone
- Include technology table
- Include Mermaid app structure diagram
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>


---

### 21 — 📡 Django REST Framework APIs
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in REST API design and documentation.
Write the DJANGO REST FRAMEWORK APIs section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
API STRUCTURE:
- Base URL: http://localhost:8000/api/
- Authentication: Token Authentication (Authorization: Token <key>)
- Response format: JSON
- Pagination: PageNumberPagination (PAGE_SIZE=20)
API GROUPS:
1. Auth APIs (/api/auth/)
   - POST /register/ — create new user account
   - POST /login/ — authenticate, return token
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
SECTION REQUIREMENTS (2000–3000 words):
1. API DESIGN PRINCIPLES
   - RESTful design conventions used
   - Resource naming conventions
   - HTTP method semantics (GET, POST, PUT, PATCH, DELETE)
   - Status codes used (200, 201, 400, 401, 403, 404, 500)
2. ENDPOINT DOCUMENTATION
   For EACH endpoint, provide:
   - HTTP Method + URL
   - Description
   - Authentication required (Yes/No)
   - Request body (JSON example)
   - Response body (JSON example)
   - Status codes
   Present as formatted tables or structured blocks
3. SERIALIZER ARCHITECTURE
   - How DRF serializers validate and transform data
   - Key serializers: UserSerializer, CameraSerializer, FireEventSerializer, FCMDeviceSerializer
   - Nested serialization (e.g., camera details inside event)
4. VIEW ARCHITECTURE
   - ViewSets vs. APIViews used
   - Custom actions (@action decorator for resolve, false-alarm, stats)
   - Permission classes applied
5. URL ROUTING
   - Django URL configuration structure
   - DRF Router usage
   - Include a table mapping URL patterns to views
FORMATTING:
- Include API endpoint tables with request/response examples
- Include a Mermaid diagram showing the URL routing structure
- Include JSON code blocks for request/response examples
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 22 — 🔐 Authentication & Security
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in web application security.
Write the AUTHENTICATION AND SECURITY section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
SECURITY CONTEXT:
- DRF Token Authentication (rest_framework.authtoken)
- Default permission: IsAuthenticated (all API endpoints require authentication)
- CORS: CORS_ALLOW_ALL_ORIGINS = True (development — noted as requiring restriction in production)
- Password hashing: Django's default PBKDF2 with SHA256
- Firebase service account credentials stored as JSON file
- Flutter: flutter_secure_storage for token persistence on device
- No plaintext passwords stored anywhere
SECTION REQUIREMENTS (1000–1500 words):
1. AUTHENTICATION FLOW
   - User registration → password hashed → stored in auth_user table
   - Login → validate credentials → generate Token → return to client
   - Subsequent requests → include "Authorization: Token <key>" header
   - Logout → delete token from database
   - Include a Mermaid sequence diagram of the complete auth flow
2. TOKEN-BASED AUTHENTICATION
   - How DRF TokenAuthentication works
   - Token storage in the database (authtoken_token table)
   - Token transmission in HTTP headers
   - Token invalidation on logout
   - Comparison with JWT (why token auth was chosen for simplicity)
3. AUTHORIZATION
   - IsAuthenticated permission class
   - How it applies to all viewsets
   - Admin access via Django admin panel (is_staff flag)
4. MOBILE-SIDE SECURITY
   - flutter_secure_storage for encrypted token storage
   - Dio interceptor for automatic token injection
   - Auto-logout on 401 responses
5. SECURITY CONSIDERATIONS
   - HTTPS recommendation for production
   - CORS restriction for production
   - Firebase credential management best practices
   - Rate limiting considerations (not implemented — noted as future work)
   - Include a security assessment table:
     | Threat | Current Status | Mitigation | Priority |
FORMATTING:
- Include Mermaid auth flow diagram
- Include security assessment table
- Include code snippets showing auth configuration
- Formal academic tone
- Placeholder citations on web security best practices

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 23 — 🔔 Firebase Notification System
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in mobile notification systems.
Write the FIREBASE NOTIFICATION SYSTEM section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
FIREBASE CONTEXT:
- Firebase Cloud Messaging (FCM) for push notifications
- firebase-admin SDK (Python) on Django backend
- firebase_core + firebase_messaging (Flutter) on mobile app
- Notification types: fire_alert, smoke_alert, event_resolved
- Multicast delivery: send_each_for_multicast() to all opted-in devices
- Notification preferences: users can toggle fire/smoke/resolved alerts
- Platform configs: google-services.json (Android), GoogleService-Info.plist (iOS)
- Android notification channel: "alerts" (high importance, red LED, vibration)
- Graceful degradation: if Firebase init fails, app continues without push
SECTION REQUIREMENTS (1500–2000 words):
1. FIREBASE CLOUD MESSAGING OVERVIEW
   - What FCM is and how it works (client → FCM server → device)
   - Message types: notification messages vs. data messages
   - Why FCM was chosen over alternatives (OneSignal, Pusher, custom WebSocket)
   - Include a comparison table of push notification services
2. BACKEND IMPLEMENTATION
   - Firebase initialization in Django (firebase.py → AppConfig.ready())
   - Idempotent initialization with _apps check
   - FCM dispatch functions:
     * send_fire_alert_to_all(event) — multicast to all devices with fire_alerts=True
     * send_resolved_alert(event) — notify when event is resolved
     * send_test_push(token) — single device test
   - Notification payload structure (notification block + data block)
   - Include payload JSON example
   - Include a Mermaid sequence diagram: Event Created → Filter Opted-in Users → Collect Tokens → Multicast → FCM → Devices
3. MOBILE IMPLEMENTATION
   - Firebase initialization in Flutter (main.dart)
   - Token lifecycle: get token → register with backend → refresh handling
   - Foreground message handling (_handleForegroundMessage)
   - Background message handling
   - Local notification display (flutter_local_notifications)
   - AlarmService: siren audio + vibration on fire alerts
   - Full-screen alert navigation on notification tap
4. NOTIFICATION PREFERENCES
   - NotificationPreference model (fire_alerts, resolved_alerts, false_alarm_alerts, sound_enabled)
   - User-level opt-in/opt-out
   - Backend filters devices based on preferences before sending
5. PLATFORM-SPECIFIC CONFIGURATION
   - Android: notification channel setup, importance level, fullScreenIntent
   - iOS: APNS priority, interruption level (critical)
   - Include a table comparing Android vs. iOS notification behavior
FORMATTING:
- Include Mermaid notification flow diagram
- Include JSON payload examples
- Include platform comparison table
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 24 — 💾 SQLite Database Design
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in database design.
Write the SQLITE DATABASE DESIGN section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
DATABASE CONTEXT:
- Engine: SQLite3 (built-in Python, zero configuration)
- ORM: Django ORM (models define schema, migrations manage evolution)
- Location: backend/db.sqlite3 (file-based, inside container)
- Django apps and their models:
  * accounts: UserProfile (phone, avatar — extends auth.User via OneToOneField)
  * cameras: Zone (name, description), Camera (name, location, stream_url, thumbnail, status)
  * events: FireEvent (event_type, status, ai_confidence, snapshot, notes, detected_at, resolved_at)
  * notifications: FCMDevice (token, platform, is_active), NotificationPreference (fire/resolved/false_alarm/sound flags)
SECTION REQUIREMENTS (1500–2000 words):
1. DATABASE SELECTION JUSTIFICATION
   - Why SQLite was chosen over PostgreSQL/MySQL for this project
   - Advantages: zero configuration, file-based, no separate server
   - Limitations: single writer, no concurrent write scaling
   - Why limitations are acceptable for this project's scale
   - Include a comparison table: SQLite vs. PostgreSQL vs. MySQL
2. DATABASE SCHEMA
   For each table, describe:
   - Table name
   - Columns: name, type, constraints (PK, FK, NOT NULL, UNIQUE, DEFAULT)
   - Relationships to other tables
   - Present as structured tables
3. ENTITY DESCRIPTIONS
   Describe each entity's purpose and business rules:
   - User (Django built-in auth_user)
   - UserProfile (1:1 extension)
   - Zone (logical grouping for cameras)
   - Camera (physical device, belongs to zone)
   - FireEvent (detection record, belongs to camera)
   - FCMDevice (push notification token, belongs to user)
   - NotificationPreference (per-user settings, 1:1 with user)
4. DJANGO MIGRATIONS
   - How Django generates and applies migrations
   - Migration files and version control
   - migrate --noinput in entrypoint.sh for Docker startup
5. QUERY PATTERNS
   - Most common queries (list active events, count by type, filter by camera)
   - Django ORM query examples
   - Indexing considerations
FORMATTING:
- Include complete schema tables for each model
- Include a relationship summary table
- Include Django model code snippets
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 25 — 📊 ERD Explanation
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in database modeling and ER diagrams.
Write the ENTITY-RELATIONSHIP DIAGRAM (ERD) EXPLANATION section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
DATABASE ENTITIES:
- User (Django auth_user: id, username, email, password, is_staff, is_active)
- UserProfile (phone, avatar — OneToOneField to User)
- NotificationPreference (fire_alerts, resolved_alerts, false_alarm_alerts, sound_enabled — OneToOneField to User)
- FCMDevice (token, platform, is_active — ForeignKey to User)
- Zone (name, description, created_at)
- Camera (name, location, stream_url, thumbnail, status — ForeignKey to Zone)
- FireEvent (event_type, status, ai_confidence, snapshot, notes, detected_at, resolved_at — ForeignKey to Camera)
RELATIONSHIPS:
- User 1:1 UserProfile
- User 1:1 NotificationPreference
- User 1:N FCMDevice (one user, multiple devices)
- Zone 1:N Camera (one zone, multiple cameras)
- Camera 1:N FireEvent (one camera, multiple events)
SECTION REQUIREMENTS (1000–1500 words):
1. ERD DIAGRAM
   - Provide a Mermaid erDiagram showing all entities and relationships
   - Include all columns with data types
   - Show cardinality (1:1, 1:N)
   - Mark primary keys (PK) and foreign keys (FK)
2. ENTITY DESCRIPTIONS
   For each entity, provide:
   - Purpose in the system
   - Key attributes and their data types
   - Business rules and constraints
   - Relationship explanation in natural language
3. RELATIONSHIP ANALYSIS
   - Explain each relationship with examples:
     * "A User has exactly one UserProfile" (1:1, auto-created via Django signal)
     * "A Zone contains zero or more Cameras" (1:N)
     * "A Camera triggers zero or more FireEvents" (1:N)
   - Referential integrity: CASCADE vs. SET_NULL on delete
   - Include a relationship matrix table
4. NORMALIZATION
   - Discuss the normalization form of the schema (3NF)
   - Identify any denormalization decisions and their justification
FORMATTING:
- Include complete Mermaid erDiagram
- Include relationship matrix table
- Include entity description tables
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
<br/>

## 📱 FRONTEND

---
### 26 — 📱 Frontend / Flutter Chapter
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in mobile application development.
Write the FRONTEND / FLUTTER CHAPTER introduction for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
FLUTTER CONTEXT:
- Framework: Flutter 3.9+ / Dart ^3.9
- Architecture: Feature-first clean architecture
- State management: Provider ^6.1.5
- HTTP client: Dio ^5.7.0 with auth interceptor
- Navigation: go_router ^17.2.1
- Push notifications: firebase_core ^3.13 + firebase_messaging ^15.2
- Local notifications: flutter_local_notifications ^18.0
- Responsive sizing: flutter_screenutil ^5.9.3
- Secure storage: flutter_secure_storage ^9.2.2
- Audio: audioplayers ^6.4.0 (alarm siren)
- Haptic: vibration ^3.1.0
- Feature modules: splash, auth (login/signup/forgot_password), home, cameras, alert, notification, settings
- Core modules: constant, models, navigation, services, theme, widgets
SECTION REQUIREMENTS (1000–1500 words):
1. FLUTTER FRAMEWORK OVERVIEW
   - What Flutter is and its advantages for this project
   - Cross-platform benefit (Android + iOS from single codebase)
   - Widget-based declarative UI approach
   - Why Flutter was chosen over React Native or native development
   - Include a comparison table: Flutter vs. React Native vs. Native
2. PROJECT STRUCTURE
   - Feature-first directory organization
   - Core vs. Feature separation
   - Include a directory tree diagram
   - Include a Mermaid diagram showing feature module dependencies
3. KEY DEPENDENCIES
   - Table of all major packages with version, purpose, and justification
   - Include pubspec.yaml key entries
4. CHAPTER ROADMAP
   - List subsections: state management, UI/UX, screens walkthrough
FORMATTING:
- Include dependency table
- Include directory structure diagram
- Include Mermaid feature dependency diagram
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 27 — 🔄 State Management & Providers
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in Flutter state management.
Write the STATE MANAGEMENT AND PROVIDERS section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
STATE MANAGEMENT CONTEXT:
- Pattern: Provider (ChangeNotifier-based)
- Root: MultiProvider wrapping the entire MaterialApp
- Providers:
  * AuthProvider — login state, user data, token management
  * HomeProvider — dashboard stats, recent activity, system status
  * CameraProvider — camera list, CRUD operations, stats
  * AlertProvider — active alert state, siren control, resolution actions
  * NotificationProvider — notification history, tab filtering, preferences
  * SplashProvider — initial auth check, auto-navigation
SECTION REQUIREMENTS (1500–2000 words):
1. STATE MANAGEMENT APPROACH COMPARISON
   - Compare Provider vs. BLoC vs. Riverpod vs. GetX
   - Why Provider was chosen (simplicity, official recommendation, sufficient for this project's complexity)
   - Include a comparison table
2. PROVIDER ARCHITECTURE
   - ChangeNotifier base class explanation
   - notifyListeners() mechanism
   - Consumer and context.read/watch patterns
   - MultiProvider setup at app root
   - Include a Mermaid diagram showing provider tree structure
3. PROVIDER DESCRIPTIONS
   For each provider, describe:
   - Responsibility
   - Key state variables
   - Key methods
   - API calls made
   - How it connects to the UI layer
   - Present as a structured table
4. DATA FLOW
   - UI Action → Provider Method → API Service → Backend → Response → State Update → UI Rebuild
   - Include a Mermaid sequence diagram for a typical flow (e.g., "Load home dashboard")
5. ERROR HANDLING IN PROVIDERS
   - Loading states (isLoading flag)
   - Error states (errorMessage)
   - UI feedback (SnackBar, error widgets)
FORMATTING:
- Include comparison table
- Include Mermaid diagrams (provider tree, data flow)
- Include provider summary table
- Include code snippets showing provider patterns
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 28 — 🎨 UI/UX Discussion
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in mobile UI/UX design.
Write the UI/UX DISCUSSION section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
UI/UX CONTEXT:
- Dark theme design with emergency-focused color palette
- Custom color system: AppColors class with dark backgrounds and accent colors
- Typography: Custom text styles via AppTextStyle
- Responsive design: flutter_screenutil for screen-size adaptation
- Navigation: go_router with named routes
- Emergency UX: Full-screen alert with red pulsing background, siren audio, vibration
SCREENS:
1. SplashScreen — animated logo, auto-auth check
2. LoginScreen — email/password, forgot password link
3. SignupScreen — registration form
4. ForgotPasswordScreen — email-based password reset
5. HomeScreen — system status card, camera network stats, recent activity, simulate alert toggle
6. CamerasScreen — camera grid, add/delete camera functionality
7. AlertScreen — FULL-SCREEN emergency: pulsing red background, event details, camera feed placeholder, "Mark Resolved" / "False Alarm" action buttons, siren + vibration
8. NotificationScreen — tabbed notification history (All, Fire, Smoke, Resolved)
9. SettingsScreen — notification preferences, profile, logout
SECTION REQUIREMENTS (1500–2000 words):
1. DESIGN PHILOSOPHY
   - Safety-first design: emergency visibility over aesthetics
   - Dark theme justification (reduces eye strain in monitoring scenarios, makes red alerts stand out)
   - Color psychology: red for danger, green for safe, amber for warning
   - Minimal interaction during emergencies (large touch targets, simple actions)
2. SCREEN-BY-SCREEN WALKTHROUGH
   For each screen, describe:
   - Purpose and user goal
   - Key UI elements
   - User interactions
   - Navigation connections
   - Include figure placeholders: "Figure X: [ScreenName] screen screenshot"
3. EMERGENCY UX DESIGN
   - Full-screen alert rationale (cannot be dismissed accidentally)
   - Multi-sensory feedback: visual (pulsing red) + audio (siren) + haptic (vibration)
   - Clear action buttons: "Mark Resolved" and "False Alarm"
   - Event information display: camera name, zone, event type, confidence, timestamp
   - Include a figure placeholder for the alert screen
4. RESPONSIVE DESIGN
   - flutter_screenutil configuration and usage
   - How layouts adapt to different screen sizes
   - Font scaling and spacing calculations
5. NAVIGATION ARCHITECTURE
   - go_router route definitions
   - Named routes and path parameters
   - Auth-guarded routes (redirect to login if unauthenticated)
   - Include a Mermaid diagram of the navigation graph
6. ACCESSIBILITY CONSIDERATIONS
   - Color contrast ratios
   - Touch target sizes
   - Screen reader compatibility (semantic widgets)
FORMATTING:
- Include navigation graph Mermaid diagram
- Include figure placeholders for ALL screens
- Include a color palette table with hex codes and usage
- Formal academic tone
- Suggest infographic: "Emergency alert UX multi-sensory feedback model"

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
<br/>

## 🐳 DEVOPS / DEPLOYMENT
---
### 29 — 🐳 Deployment Chapter
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in DevOps and deployment.
Write the DEPLOYMENT CHAPTER introduction for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
DEPLOYMENT CONTEXT:
- Docker and Docker Compose for containerization
- Three services: ai_service, backend, db (postgres provisioned but SQLite used)
- Bridge network: app_network
- Backend entry: entrypoint.sh (migrate → collectstatic → gunicorn)
- AI Service entry: uvicorn main:app --host 0.0.0.0 --port 8001
- Health checks on all services
- PythonAnywhere as alternative cloud host for backend
- Flutter app built for Android (APK) and iOS
SECTION REQUIREMENTS (800–1200 words):
1. DEPLOYMENT STRATEGY OVERVIEW
   - Local development workflow
   - Docker-based deployment workflow
   - Cloud deployment (PythonAnywhere)
   - Mobile app distribution
   - Include a deployment options comparison table
2. INFRASTRUCTURE DIAGRAM
   - Mermaid diagram showing Docker Compose topology
   - Service containers, ports, networks, volumes
   - External connections (Firebase, mobile devices, camera)
3. CHAPTER ROADMAP
   - Docker architecture details
   - FastAPI deployment
   - Gunicorn deployment
   - Mobile app build and distribution
FORMATTING:
- Include Mermaid infrastructure diagram
- Include deployment comparison table
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 30 — 📦 Docker Architecture
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in containerization and Docker.
Write the DOCKER ARCHITECTURE section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
DOCKER CONTEXT:
- docker-compose.yml (version: "3.10") with 3 services
- AI Service Dockerfile: python:3.10-slim + libgl1/libglib2.0-0/libsm6/libxext6/libxrender1/libxcb1 + pip requirements + COPY . . + CMD uvicorn
- Backend Dockerfile: python:3.10-slim + pip requirements + COPY . . + sed CRLF fix + ENTRYPOINT entrypoint.sh
- db service: postgres:15-alpine (provisioned for future migration, not actively used by Django)
- Network: app_network (bridge driver)
- Volume: postgres_data (named volume for Postgres data)
- Health checks: python urllib.request.urlopen for ai_service and backend, pg_isready for db
- Environment variables passed via docker-compose.yml
SECTION REQUIREMENTS (1500–2000 words):
1. DOCKER AND CONTAINERIZATION OVERVIEW
   - What Docker is and why it's important for microservices
   - Containers vs. VMs comparison
   - Docker Compose for multi-container orchestration
   - Include a comparison table: Docker vs. VM
2. DOCKERFILE ANALYSIS
   For each Dockerfile, provide line-by-line explanation:
   - Base image selection and justification
   - System dependency installation (AI service needs OpenCV native libs)
   - Requirements installation strategy (layer caching optimization)
   - Code copy strategy
   - Entrypoint vs. CMD
   - Include annotated Dockerfile code blocks
3. DOCKER COMPOSE CONFIGURATION
   - Service definitions and their relationships
   - depends_on with health check conditions
   - Port mapping strategy
   - Environment variable injection
   - Network configuration (bridge driver, DNS resolution)
   - Volume management
   - Include the full docker-compose.yml with line-by-line annotations
4. BUILD AND RUN WORKFLOW
   - docker compose up --build
   - Build order and layer caching
   - Container startup sequence (db → ai_service → backend)
   - Include a Mermaid sequence diagram of the startup sequence
5. HEALTH CHECK STRATEGY
   - Why health checks are important
   - Implementation for each service
   - Retry and interval configuration
   - Include a health check configuration table
FORMATTING:
- Include annotated Dockerfile and docker-compose.yml code blocks
- Include Mermaid startup sequence diagram
- Include Docker vs. VM comparison table
- Include health check table
- Formal academic tone
- Figure/table caption placeholders

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```

</details>

---
### 31 — ⚡ FastAPI Deployment
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in Python web frameworks and API deployment.
Write the FASTAPI DEPLOYMENT section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
FASTAPI CONTEXT:
- FastAPI 0.110+ serves the AI inference endpoint
- Server: Uvicorn (ASGI) — single worker for model thread safety
- Endpoints: GET / (health), GET /status, GET /cameras, POST /predict
- Model loaded at import time (module-level initialization)
- Warmup: dummy inference on startup to avoid cold-start latency
- Container: python:3.10-slim with OpenCV native dependencies
SECTION REQUIREMENTS (1000–1500 words):
1. FASTAPI FRAMEWORK OVERVIEW
   - What FastAPI is (modern, fast, async-first Python framework)
   - Built on Starlette (ASGI) and Pydantic (validation)
   - Automatic OpenAPI/Swagger documentation generation
   - Why FastAPI was chosen over Flask, Django, or Tornado for the AI service
   - Include a comparison table: FastAPI vs. Flask vs. Django for AI serving
2. UVICORN ASGI SERVER
   - What Uvicorn is and how it serves FastAPI
   - ASGI vs. WSGI comparison
   - Single-worker configuration for model thread safety
   - Include a comparison table: Uvicorn vs. Gunicorn for async workloads
3. ENDPOINT ARCHITECTURE
   - Describe each endpoint with its purpose, inputs, and outputs
   - The /predict endpoint in detail:
     * Input: multipart file upload + camera_id query parameter
     * Processing: image validation → inference → threshold check → optional backend notification
     * Output: JSON {event_type, confidence, detections[]}
   - Include API endpoint table
4. MODEL LIFECYCLE
   - Model loaded once at module import (not per-request)
   - Warm-up inference to pre-allocate GPU/CPU memory
   - Thread safety considerations (single worker avoids concurrent model access)
5. DEPLOYMENT COMMANDS
   - Docker CMD: uvicorn main:app --host 0.0.0.0 --port 8001
   - Local development: uvicorn main:app --reload
   - Include command examples
FORMATTING:
- Include framework comparison table
- Include API endpoint documentation table
- Include code snippets
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 32 — 🦄 Gunicorn Deployment
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in Python web server deployment.
Write the GUNICORN DEPLOYMENT section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
GUNICORN CONTEXT:
- Gunicorn 21.2 as the WSGI production server for Django
- Configuration: --bind 0.0.0.0:8000 --workers 3
- Started via entrypoint.sh after migrations and collectstatic
- entrypoint.sh uses exec to replace shell process (proper PID 1 handling)
- Procfile also available: web: gunicorn fireguard.wsgi (for PythonAnywhere/Heroku)
- WSGI application: fireguard.wsgi:application
SECTION REQUIREMENTS (800–1200 words):
1. GUNICORN OVERVIEW
   - What Gunicorn is (Green Unicorn — Python WSGI HTTP Server)
   - Pre-fork worker model explanation
   - Why Gunicorn is needed (Django's runserver is NOT production-ready)
   - Include a comparison: Django runserver vs. Gunicorn
2. WORKER CONFIGURATION
   - Number of workers: 3 (formula: 2xCPU cores + 1)
   - Worker type: sync (default, suitable for Django + SQLite)
   - Why async workers (gevent/uvicorn) were not needed
   - Connection handling and request lifecycle
3. ENTRYPOINT SCRIPT WALKTHROUGH
   - Line-by-line explanation of entrypoint.sh
   - set -e: exit on error
   - migrate --noinput: apply database migrations automatically
   - collectstatic --noinput || true: gather static files, non-fatal
   - exec gunicorn: replace shell with gunicorn (signal forwarding for Docker)
4. PRODUCTION CONSIDERATIONS
   - Static file serving (collectstatic + reverse proxy recommendation)
   - Graceful shutdown handling
   - Logging configuration
   - Timeout settings
FORMATTING:
- Include entrypoint.sh annotated code block
- Include Django runserver vs. Gunicorn comparison table
- Formal academic tone

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
<br/>

## ✅ QUALITY

---
### 33 — 🧪 Testing & Validation
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in software testing and quality assurance.
Write the TESTING AND VALIDATION chapter for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
TESTING CONTEXT:
- AI model evaluation: mAP, precision, recall, F1, confusion matrix
- API testing: manual testing with curl/Postman, health check endpoints
- Mobile app testing: manual testing on physical Android devices
- Integration testing: end-to-end detection → notification flow
- Live demo testing: USB camera → AI detection → push notification → mobile alert
SECTION REQUIREMENTS (2000–2500 words):
1. TESTING STRATEGY OVERVIEW
   - Testing levels: unit, integration, system, acceptance
   - Which levels were applied and which were prioritized
   - Testing tools used
   - Include a testing matrix table: Test Type | Scope | Tool | Status
2. AI MODEL VALIDATION
   - Evaluation metrics: Precision, Recall, F1-Score, mAP@0.5, mAP@0.5:0.95
   - Validation dataset results
   - Confusion matrix analysis (fire vs. smoke vs. background)
   - Per-class performance breakdown
   - Sample detection results (figure suggestions)
   - Include results tables with placeholder metrics
   - Include figure placeholders: PR curve, confusion matrix, sample detections
3. API TESTING
   - REST API endpoint testing methodology
   - Test cases for each endpoint group (auth, cameras, events, notifications)
   - Status code validation
   - Authentication flow testing
   - Error handling testing (invalid inputs, missing fields)
   - Include a test case table: Test ID | Endpoint | Input | Expected Output | Result
4. MOBILE APP TESTING
   - UI testing on physical devices
   - Devices tested: [list Android devices with OS version]
   - Screen-by-screen functionality verification
   - Push notification testing (foreground, background, app killed)
   - Emergency alert UX testing (siren, vibration, full-screen)
5. INTEGRATION TESTING
   - End-to-end flow: camera → AI service → backend → Firebase → mobile
   - Docker Compose deployment testing
   - Service health check verification
   - Inter-service communication testing
   - Include a Mermaid diagram of the integration test flow
6. LIVE DEMO TESTING
   - USB camera setup and detection verification
   - Real fire/smoke simulation (controlled environment)
   - Response time measurement
   - False positive/negative analysis during demo
   - Include a demo test results table
7. KNOWN LIMITATIONS
   - Areas not tested (load testing, security penetration testing)
   - Documented for future work
FORMATTING:
- Include comprehensive test results tables
- Include Mermaid integration test flow diagram
- Include figure placeholders for AI evaluation charts
- Formal academic tone
- Placeholder metrics in square brackets

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
<br/>

## 📊 RESULTS

---
### 34 — 📊 Results & Performance Analysis
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer specializing in ML performance analysis and system evaluation.
Write the RESULTS AND PERFORMANCE ANALYSIS chapter for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
SECTION REQUIREMENTS (2000–3000 words):
1. AI MODEL PERFORMANCE
   - Present all model evaluation metrics in a structured format:
   - Include tables:
     * Overall metrics: mAP@0.5, mAP@0.5:0.95, overall precision, overall recall
     * Per-class metrics: fire precision/recall/F1, smoke precision/recall/F1
     * Inference speed: FPS, ms per frame, hardware specs
   - Include figure placeholders:
     * "Figure X: Precision-Recall curve"
     * "Figure X: F1-Confidence curve"
     * "Figure X: Confusion matrix"
     * "Figure X: Training loss curves (box, cls, dfl)"
     * "Figure X: mAP progression over training epochs"
     * "Figure X: Sample detection results on test images"
   - Analysis of results: what worked well, where the model struggles
   - Comparison with related work (placeholder table comparing with other papers' results)
2. SYSTEM PERFORMANCE
   - End-to-end latency measurements:
     | Stage | Latency |
     | Frame capture | [X] ms |
     | Network transfer | [X] ms |
     | AI inference | [X] ms |
     | Backend processing | [X] ms |
     | FCM delivery | [X] ms |
     | Total | [X] ms |
   - API response time measurements
   - Concurrent request handling capacity
   - Docker resource consumption (CPU, memory per container)
3. NOTIFICATION DELIVERY PERFORMANCE
   - FCM delivery success rate
   - Average notification latency
   - Comparison: foreground vs. background delivery time
   - Include a performance metrics table
4. MOBILE APP PERFORMANCE
   - App startup time
   - Screen transition performance
   - Memory consumption
   - Battery impact during monitoring
5. COMPARATIVE ANALYSIS
   - Compare FireGuard's performance against literature results
   - Include a comparison table: FireGuard vs. [Paper 1] vs. [Paper 2]
   - Discuss where FireGuard excels and where it falls short
6. DISCUSSION
   - Interpret the results in the context of the project objectives
   - Were the objectives met? (refer back to each specific objective)
   - Limitations discovered during evaluation
   - Threats to validity
FORMATTING:
- Include at least 5 performance tables
- Include at least 6 figure placeholders for charts and curves
- Include comparative analysis table
- Formal academic tone
- Placeholder metrics throughout
- Suggest infographic: "End-to-end detection pipeline performance waterfall chart"

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 35 — ⚠️ Challenges & Problems Faced
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer helping document project challenges honestly and professionally.
Write the CHALLENGES AND PROBLEMS FACED section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
KNOWN CHALLENGES (use these as starting points, expand each):
1. TECHNICAL CHALLENGES
   - YOLOv8 model training on limited GPU resources
   - OpenCV native library dependencies in Docker (libgl1, libglib2.0-0)
   - Windows CRLF line endings breaking entrypoint.sh in Linux containers
   - SQLite concurrent write limitations with Gunicorn workers
   - Firebase initialization failures when credentials are missing
   - USB camera driver compatibility across different operating systems
   - WiFi camera latency and frame drop during live demo
   - Large model file (best.pt ~6MB) in git repository
   - PyTorch/CUDA version compatibility issues
   - Docker image size optimization (OpenCV + PyTorch = large images)
2. INTEGRATION CHALLENGES
   - Synchronizing AI service and backend Docker containers (health checks, depends_on)
   - Flutter FCM token lifecycle management (registration, refresh, unregister)
   - Android notification channel configuration for high-importance alerts
   - CORS configuration for cross-origin Flutter-Django communication
   - Environment variable management across three services
3. DEVELOPMENT WORKFLOW CHALLENGES
   - Team coordination across frontend, backend, and AI development
   - Git workflow for multi-service repository
   - Testing end-to-end flow requires all services running simultaneously
   - Debugging inter-service communication issues
4. DEPLOYMENT CHALLENGES
   - PythonAnywhere free tier limitations (no outbound HTTP for Firebase)
   - Docker Compose orchestration on different host operating systems
   - Model deployment without GPU (CPU-only inference performance)
FOR EACH CHALLENGE, provide:
- Problem description
- Impact on the project
- Solution or workaround applied
- Lessons learned
FORMATTING:
- Present as a table: Challenge | Category | Impact | Solution | Lesson Learned
- OR as numbered subsections with consistent structure
- Honest, professional tone — challenges make the project credible
- Formal academic style
- Include a summary of key lessons learned at the end

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 36 — 🔮 Future Work
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer helping document future development directions.
Write the FUTURE WORK section for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
FUTURE DIRECTIONS (expand each with technical justification):
1. AI IMPROVEMENTS
   - Multi-class detection (add: person, vehicle, animal for evacuation tracking)
   - Model quantization (INT8/FP16) for edge deployment on Raspberry Pi or Jetson Nano
   - Model export to ONNX or TensorRT for faster inference
   - Ensemble models for reducing false positives
   - Temporal analysis (video-based detection using consecutive frames)
   - Severity estimation (small fire vs. large fire)
2. BACKEND IMPROVEMENTS
   - PostgreSQL migration for production scalability
   - WebSocket real-time dashboard (Django Channels)
   - API rate limiting and throttling
   - Role-based access control (admin, operator, viewer)
   - Event analytics and reporting dashboard
   - Automated event report generation (PDF)
3. MOBILE APP IMPROVEMENTS
   - Live camera feed streaming in the app
   - In-app camera management with thumbnails
   - Offline mode with local database caching
   - Dark/light theme toggle
   - Multi-language support (Arabic, English)
   - iOS App Store and Google Play Store distribution
4. INFRASTRUCTURE IMPROVEMENTS
   - Kubernetes deployment for production scaling
   - CI/CD pipeline (GitHub Actions for automated testing and deployment)
   - Centralized logging (ELK stack or Grafana Loki)
   - Prometheus/Grafana monitoring
   - HTTPS and SSL/TLS certificate management
5. HARDWARE IMPROVEMENTS
   - RTSP IP camera support (multiple simultaneous cameras)
   - Edge AI: on-camera inference using Coral TPU or NVIDIA Jetson
   - Integration with building management systems (BMS)
   - IoT sensor fusion (combine camera detection with smoke/heat sensors)
FORMAT:
- Present as a table: Category | Improvement | Priority (High/Medium/Low) | Estimated Effort | Impact
- Formal academic tone
- Include a Mermaid roadmap diagram showing short-term vs. medium-term vs. long-term improvements
- Include brief technical justification for each item
- Placeholder citations for relevant technologies

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
<br/>

## 📄 END MATTER

---

### 37 — 🏁 Conclusion
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer crafting a strong project conclusion.
Write the CONCLUSION chapter for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
SECTION REQUIREMENTS (800–1200 words):
1. PROJECT SUMMARY (1–2 paragraphs)
   - Restate the problem (fire detection limitations)
   - Summarize the solution (FireGuard system)
   - Highlight the key technologies used
2. OBJECTIVES ACHIEVEMENT
   - Revisit EACH specific objective from the Objectives chapter
   - State whether it was fully achieved, partially achieved, or not achieved
   - Include a table: Objective | Status (Achieved/Partial/Not Achieved) | Evidence
   - Use placeholder metrics where needed
3. KEY CONTRIBUTIONS
   - What this project contributes to the field (list 3–5 contributions):
     * End-to-end real-time fire detection pipeline
     * Mobile-first emergency alert system
     * Microservice architecture for AI deployment
     * Open-source, affordable, and reproducible
     * Live demo with physical camera integration
4. LIMITATIONS
   - Honest assessment of current limitations (2–3 sentences)
   - Reference the Challenges chapter for details
5. FINAL REMARKS
   - Significance of the work
   - Potential for real-world impact
   - Closing statement about the role of AI in public safety
   - 1–2 sentences about the team's professional growth
FORMATTING:
- Formal academic tone, third person
- Include objectives achievement table
- Do NOT introduce new information not discussed in the report
- Do NOT include citations (conclusions summarize, they don't cite)
- Strong, confident closing paragraph

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 38 — 📚 References Formatting
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic writing assistant specializing in citation formatting.
Generate a REFERENCES section template for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
REQUIREMENTS:
1. CITATION STYLE
   - Use IEEE citation style (numbered references in square brackets)
   - Format: [#] Author(s), "Title," Source, vol., no., pp., Month Year.
2. GENERATE REFERENCE ENTRIES for the following categories:
   FIRE DETECTION & SAFETY (5–8 references):
   - Fire hazard statistics (WHO, NFPA reports)
   - Traditional fire detection systems
   - AI in fire safety literature
   COMPUTER VISION & DEEP LEARNING (5–8 references):
   - YOLO papers (original YOLO, YOLOv3, YOLOv5, YOLOv8)
   - Object detection surveys
   - Fire detection using deep learning papers
   - Transfer learning references
   FRAMEWORKS & TOOLS (5–8 references):
   - Django documentation
   - FastAPI documentation
   - Flutter documentation
   - Firebase documentation
   - Docker documentation
   - PyTorch reference
   - Ultralytics YOLOv8 reference
   - Roboflow reference
   - OpenCV reference
   DATASETS (3–5 references):
   - Public fire/smoke datasets
   - Dataset annotation methodologies
   SOFTWARE ENGINEERING (3–5 references):
   - Microservice architecture
   - REST API design
   - Mobile app development best practices
3. TOTAL: Generate 25–35 properly formatted IEEE references
4. For each reference, ensure:
   - Correct author names (real authors for published papers)
   - Correct publication year
   - Correct journal/conference name
   - DOI or URL where applicable
   - For documentation, use the official website URL with access date
FORMATTING:
- Numbered list [1] through [35]
- IEEE format strictly
- Include a note about verifying each reference's accuracy before submission

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 39 — 📎 Appendix Generation
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic engineering writer helping prepare appendices for a graduation project report.
Generate APPENDIX content templates for a graduation project report/book.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
Generate templates for the following appendices:
APPENDIX A: FULL API REFERENCE
- Complete REST API documentation in tabular format
- All endpoints with method, URL, auth requirement, request/response schema
- Organized by API group (Auth, Cameras, Events, Notifications)
APPENDIX B: DATABASE SCHEMA
- Complete SQL CREATE TABLE statements (or Django model definitions)
- All fields, types, constraints, foreign keys
- Index definitions
APPENDIX C: ENVIRONMENT VARIABLES
- Complete list of all environment variables across all services
- Table: Variable | Service | Default | Description | Required
APPENDIX D: DOCKER CONFIGURATION
- Full docker-compose.yml with annotations
- Both Dockerfiles with annotations
- entrypoint.sh with annotations
APPENDIX E: YOLOv8 TRAINING CONFIGURATION
- Complete training hyperparameters
- data.yaml file content
- Training command used
- Hardware specifications
APPENDIX F: FLUTTER DEPENDENCY LIST
- Complete pubspec.yaml dependencies section
- Table: Package | Version | Purpose
APPENDIX G: PROJECT TIMELINE / GANTT CHART
- Suggest a Mermaid Gantt chart covering:
  * Phase 1: Research & Planning (weeks 1–3)
  * Phase 2: Dataset Collection & AI Training (weeks 4–7)
  * Phase 3: Backend Development (weeks 5–9)
  * Phase 4: Frontend Development (weeks 7–11)
  * Phase 5: Integration & Testing (weeks 10–13)
  * Phase 6: Documentation & Deployment (weeks 12–15)
APPENDIX H: GLOSSARY
- Technical terms and acronyms used in the report
- 30–40 terms with definitions
- Include: YOLO, mAP, IoU, FCM, REST, WSGI, ASGI, ORM, CORS, DRF, etc.
FORMATTING:
- Each appendix should have a title and brief introduction paragraph
- Use tables wherever possible
- Include code blocks for configuration files
- Formal academic tone
- Label appendices A through H

IMPORTANT FORMATTING REQUIREMENTS:

- Generate the output in a format suitable for direct export to Microsoft Word (.docx)
- Use formal academic formatting
- Use Times New Roman font
- Font size:
  - Headings: 16 Bold
  - Subheadings: 14 Bold
  - Body text: 12 Regular
- Line spacing: 1.5
- Text alignment: Justified
- Include page-break suggestions between major chapters
- Use numbered headings and subheadings
- Use professional table formatting
- Add figure and table captions in IEEE academic style
- Ensure the content can be pasted directly into Microsoft Word without formatting issues
- Avoid markdown-specific syntax in the final generated report content
```
</details>

---
### 40 — 🎤 Presentation / Demo Preparation
<details>
<summary><b>Click to expand prompt</b></summary>

```
You are an academic presentation coach helping prepare a graduation project defense.
Generate a PRESENTATION AND DEMO PREPARATION guide for a graduation project defense.
PROJECT: FireGuard — AI-Powered Fire & Smoke Detection and Emergency Alert System
DEMO SETUP:
- Laptop with Docker installed
- USB-connected external WiFi camera
- Android phone with FireGuard app installed
- Internet connection for Firebase push notifications
- Projector/screen for presentation slides
REQUIREMENTS:
1. PRESENTATION SLIDE OUTLINE
   Generate a detailed slide-by-slide outline for a 20–25 minute presentation:
   Slide 1: Title slide (project name, team, supervisor, date, university logo)
   Slide 2: Agenda/outline
   Slide 3–4: Problem statement and motivation
   Slide 5: Objectives
   Slide 6–7: Literature review summary (comparison table)
   Slide 8: System architecture (Mermaid diagram or architecture image)
   Slide 9–10: AI pipeline (YOLOv8, dataset, training results)
   Slide 11: Backend architecture (Django, DRF, SQLite)
   Slide 12: Mobile app (Flutter screenshots — 4 screens in grid)
   Slide 13: Firebase notification system (flow diagram)
   Slide 14: Docker deployment (docker-compose diagram)
   Slide 15: LIVE DEMO (see below)
   Slide 16–17: Results and performance (metrics, confusion matrix, PR curve)
   Slide 18: Challenges and solutions
   Slide 19: Future work
   Slide 20: Conclusion
   Slide 21: Q&A
   Slide 22: Thank you / contact info
   For each slide, specify:
   - Title
   - Key bullet points (max 5 per slide)
   - Visual elements (diagram, screenshot, chart, table)
   - Speaker notes (2–3 sentences of what to say)
2. LIVE DEMO SCRIPT
   Step-by-step demo workflow (5–7 minutes):
   a. Show Docker containers running (docker ps)
   b. Show the Flutter app on the phone (splash → login → home)
   c. Connect USB camera and start camera.py
   d. Hold a fire/smoke image in front of camera
   e. Wait for detection → show AI service logs
   f. Show push notification arriving on the phone
   g. Show the full-screen alert on the phone (siren + vibration)
   h. Demonstrate "Mark as Resolved" button
   i. Show the event in notification history
   j. (Optional) Show Django admin panel with the event record
3. DEMO BACKUP PLAN
   - What to do if the camera doesn't work (use webcam_client.py with laptop camera)
   - What to do if Firebase doesn't deliver (show Django logs, explain the flow)
   - What to do if Docker fails to start (have pre-recorded video backup)
   - What to do if the phone has no internet (use the simulate alert button)
4. ANTICIPATED Q&A
   Generate 15–20 likely examiner questions with suggested answer outlines:
   - "Why YOLOv8 and not YOLOv5 or a transformer-based model?"
   - "What is the accuracy of your model? How does it compare to state of the art?"
   - "Why SQLite instead of PostgreSQL?"
   - "How does the system handle false positives?"
   - "What happens if Firebase is down?"
   - "Can the system handle multiple cameras simultaneously?"
   - "Why microservices instead of monolithic?"
   - "What are the main limitations?"
   - "How would you deploy this in a real building?"
   - "What is the end-to-end latency?"
   - "How was the dataset collected and annotated?"
   - "Why Flutter instead of native Android/iOS?"
   - "How do you handle security (authentication, data privacy)?"
   - "What is the role of Docker in your project?"
   - "How does the notification preference system work?"
   For each question, provide:
   - The question
   - Key talking points (3–4 bullets)
   - A confident closing statement
5. PRESENTATION DESIGN TIPS
   - Font recommendations (professional, readable)
   - Color palette (match project branding — dark theme with fire accents)
   - Slide layout guidelines (minimal text, maximum visuals)
   - Mermaid diagrams to include
   - Screenshot placement strategy
FORMATTING:
- Include the complete slide outline as a numbered list
- Include the demo script as a checklist
- Include the Q&A as a table: Question | Key Points
- Professional, coaching tone
- Suggest tools for creating the presentation (Google Slides, PowerPoint, Canva)
```
</details>

---
<br/>
<div align="center">

---
### 📌 Tips for Using These Prompts
| Tip | Description |
|---|---|
| 🎯 **Be Specific** | Replace all `[X]` placeholders with your actual data before submitting |
| 📐 **Adapt Length** | Adjust word count requirements based on your university's guidelines |
| 🔗 **Cross-Reference** | After generating sections, ensure they reference each other consistently |
| 📸 **Add Visuals** | Replace figure placeholders with actual screenshots and diagrams |
| 📖 **Verify Citations** | All generated references must be verified for accuracy |
| 🔄 **Iterate** | Don't accept the first output — ask Claude to revise, expand, or restructure |
| ✂️ **Combine** | Some prompts generate overlapping content — merge and deduplicate |
| 🗣️ **Your Voice** | Always review and add your personal observations and project-specific details |