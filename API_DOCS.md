# FireGuard — API Documentation

> Base URL: `https://bodareda0001.pythonanywhere.com` (configurable via `BACKEND_URL`)  
> Auth: `Authorization: Token <token>` on every protected endpoint.  
> Content-Type: `application/json` unless noted.

---

## Table of Contents

- [Authentication](#authentication)
- [Cameras & Zones](#cameras--zones)
- [Fire Events](#fire-events)
- [Notifications](#notifications)
- [AI Service (FastAPI)](#ai-service)

---

## Authentication

Base path: `/api/auth/`

---

### `POST /api/auth/register/`

**Auth:** None

**Request body:**
```json
{
  "username": "john",
  "email": "john@example.com",
  "first_name": "John",
  "last_name": "Doe",
  "password": "StrongPass1!",
  "password2": "StrongPass1!"
}
```

**Response `201`:**
```json
{
  "message": "Account created successfully.",
  "token": "abc123...",
  "user": {
    "id": 1,
    "username": "john",
    "email": "john@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "is_staff": false,
    "profile": { "phone": null, "avatar": null }
  }
}
```

---

### `POST /api/auth/login/`

**Auth:** None

**Request body:**
```json
{ "username": "john", "password": "StrongPass1!" }
```

**Response `200`:**
```json
{
  "message": "Login successful.",
  "token": "abc123...",
  "user": { "id": 1, "username": "john", "email": "john@example.com", "is_staff": false, "profile": {} }
}
```

**Error `401`:**
```json
{ "error": "Invalid credentials." }
```

---

### `POST /api/auth/logout/`

**Auth:** Required

**Response `200`:**
```json
{ "message": "Logged out successfully." }
```

---

### `GET /api/auth/profile/`

**Auth:** Required

**Response `200`:**
```json
{
  "id": 1,
  "username": "john",
  "email": "john@example.com",
  "first_name": "John",
  "last_name": "Doe",
  "is_staff": false,
  "profile": { "phone": "+1555000", "avatar": "/media/avatars/photo.jpg" }
}
```

---

### `PATCH /api/auth/profile/`

**Auth:** Required

**Request body** (all fields optional):
```json
{
  "first_name": "Johnny",
  "last_name": "Doe",
  "email": "new@example.com",
  "phone": "+1555999",
  "avatar": "<binary file upload>"
}
```

**Response `200`:** Updated user object (same shape as GET).

---

### `POST /api/auth/change-password/`

**Auth:** Required  
> Token is rotated on success — store the new one.

**Request body:**
```json
{
  "old_password": "OldPass1!",
  "new_password": "NewPass2!",
  "new_password2": "NewPass2!"
}
```

**Response `200`:**
```json
{ "message": "Password changed successfully.", "token": "newtoken..." }
```

---

## Cameras & Zones

Base path: `/api/cameras/`  
**Write operations** (POST / PUT / PATCH / DELETE) require `is_staff = true`. Read operations require any valid token.

---

### `GET /api/cameras/stats/`

**Auth:** Admin read-only

**Response `200`:**
```json
{ "total_units": 8, "online_now": 7, "offline": 1 }
```

---

### `GET /api/cameras/zones/`

**Auth:** Token (read)

**Response `200`:**
```json
[
  { "id": 1, "name": "Warehouse A", "description": "Ground floor", "camera_count": 3, "created_at": "2026-04-01T10:00:00Z" }
]
```

---

### `POST /api/cameras/zones/`

**Auth:** Admin

**Request body:**
```json
{ "name": "Warehouse B", "description": "First floor" }
```

**Response `201`:** Zone object.

---

### `GET /api/cameras/zones/<id>/`

**Auth:** Token

**Response `200`:** Single zone object.

---

### `PUT /api/cameras/zones/<id>/`

**Auth:** Admin — full replacement.

### `PATCH /api/cameras/zones/<id>/`

**Auth:** Admin — partial update.

### `DELETE /api/cameras/zones/<id>/`

**Auth:** Admin — **Response `204`:** `{ "message": "Zone deleted." }`

---

### `GET /api/cameras/cameras/`

**Auth:** Token  
**Query params:** `zone=<id>`, `status=online|offline`

**Response `200`:**
```json
[
  {
    "id": 1,
    "name": "Main Entrance",
    "location": "Building A — Gate 1",
    "zone": 1,
    "zone_name": "Warehouse A",
    "stream_url": "rtsp://...",
    "thumbnail": "/media/cameras/thumb.jpg",
    "status": "online",
    "created_at": "2026-04-01T10:00:00Z",
    "updated_at": "2026-04-01T10:00:00Z"
  }
]
```

---

### `POST /api/cameras/cameras/`

**Auth:** Admin

**Request body:**
```json
{ "name": "Side Door", "location": "Building B", "zone": 1, "stream_url": "rtsp://...", "status": "online" }
```

**Response `201`:** Camera object.

---

### `GET /api/cameras/cameras/<id>/`

**Auth:** Token — single camera object.

### `PUT /api/cameras/cameras/<id>/`

**Auth:** Admin — full replacement.

### `PATCH /api/cameras/cameras/<id>/`

**Auth:** Admin — partial update.

### `DELETE /api/cameras/cameras/<id>/`

**Auth:** Admin — **Response `204`:** `{ "message": "Camera deleted." }`

---

### `PATCH /api/cameras/cameras/<id>/status/`

**Auth:** Admin — toggle online / offline without touching other fields.

**Request body:**
```json
{ "status": "offline" }
```

**Response `200`:**
```json
{ "message": "Camera status updated to 'offline'.", "id": 1, "status": "offline" }
```

**Validation:** `status` must be `"online"` or `"offline"`.

---

## Fire Events

Base path: `/api/events/`

| Status values | Meaning |
| :--- | :--- |
| `active` | Unacknowledged detection |
| `resolved` | Operator marked resolved |
| `false_alarm` | Operator marked as false alarm |

---

### `GET /api/events/`

**Auth:** Token  
**Query params:** `status`, `camera`, `zone`, `type`

```
GET /api/events/?status=active&type=fire
```

**Response `200`:**
```json
[
  {
    "id": 42,
    "camera": 1,
    "camera_detail": { "id": 1, "name": "Main Entrance", "location": "Building A", "zone": 1, "zone_name": "Warehouse A", "status": "online" },
    "zone_name": "Warehouse A",
    "zone_id": 1,
    "event_type": "fire",
    "status": "active",
    "ai_confidence": 87.34,
    "snapshot": null,
    "notes": null,
    "detected_at": "2026-05-14T19:32:00Z",
    "resolved_at": null
  }
]
```

---

### `POST /api/events/`

**Auth:** None (called internally by the AI service)

**Request body:**
```json
{ "camera": 1, "event_type": "fire", "ai_confidence": 87.34 }
```

| Field | Type | Constraints |
| :--- | :--- | :--- |
| `camera` | int | Must be an **online** camera |
| `event_type` | string | `"fire"` or `"smoke"` |
| `ai_confidence` | float | `0.0 – 100.0` |
| `snapshot` | file | Optional image upload |
| `notes` | string | Optional |

**Response `201`:**
```json
{
  "message": "Event created and notification sent.",
  "event": { "id": 42, "event_type": "fire", "status": "active", "ai_confidence": 87.34, "detected_at": "2026-05-14T19:32:00Z" },
  "fcm": { "status": "sent", "success_count": 3, "failure_count": 0 }
}
```

**Error — camera offline `400`:**
```json
{ "camera": ["Cannot create an event for an offline camera."] }
```

---

### `GET /api/events/<id>/`

**Auth:** Token — single event object (same shape as list item).

---

### `PATCH /api/events/<id>/`

**Auth:** Token  
**Editable fields:** `notes` only.

```json
{ "notes": "Investigated — kitchen steam." }
```

---

### `PATCH /api/events/<id>/resolve/`

**Auth:** Token  
Sets `status = "resolved"`, stamps `resolved_at`, and fires a **resolved push** to opted-in devices.

**Response `200`:**
```json
{
  "message": "Resolved",
  "event": { "id": 42, "status": "resolved", "resolved_at": "2026-05-14T20:00:00Z" }
}
```

---

### `PATCH /api/events/<id>/false-alarm/`

**Auth:** Token  
Sets `status = "false_alarm"`, stamps `resolved_at`. No push sent.

**Response `200`:**
```json
{
  "message": "Marked as false alarm",
  "event": { "id": 42, "status": "false_alarm", "resolved_at": "2026-05-14T20:01:00Z" }
}
```

---

### `GET /api/events/active/`

**Auth:** Token  
Returns the single most-recent active event, or `{ "active": false }`.

**Response `200` — event exists:**
```json
{
  "active": true,
  "event": { "id": 42, "event_type": "fire", "status": "active", "ai_confidence": 87.34, "detected_at": "2026-05-14T19:32:00Z" }
}
```

**Response `200` — none:**
```json
{ "active": false }
```

---

### `GET /api/events/stats/`

**Auth:** Token

**Response `200`:**
```json
{
  "total": 120,
  "fire": 95,
  "smoke": 25,
  "active": 2,
  "resolved": 110,
  "false_alarm": 8
}
```

---

## Notifications

Base path: `/api/notifications/`  
All endpoints require **Token auth**.

---

### `POST /api/notifications/register-device/`

Upsert an FCM device token after login. If the token already exists it is re-assigned to the current user and activated.

**Request body:**
```json
{ "token": "fcm_token_string", "platform": "android" }
```

| Field | Values |
| :--- | :--- |
| `platform` | `"android"` or `"ios"` |

**Response `201` (new):**
```json
{
  "message": "Device registered.",
  "device": { "id": 5, "token": "fcm_token_string", "platform": "android", "is_active": true, "created_at": "2026-05-14T19:00:00Z" }
}
```

**Response `200` (updated):**
```json
{ "message": "Device updated.", "device": { ... } }
```

---

### `DELETE /api/notifications/unregister-device/`

Remove an FCM token on logout.

**Request body:**
```json
{ "token": "fcm_token_string" }
```

**Response `200`:**
```json
{ "message": "Device unregistered successfully." }
```

**Error `404`:**
```json
{ "error": "Token not found for this user." }
```

---

### `GET /api/notifications/preferences/`

**Response `200`:**
```json
{
  "id": 1,
  "fire_alerts": true,
  "resolved_alerts": true,
  "false_alarm_alerts": false,
  "sound_enabled": true,
  "updated_at": "2026-05-01T12:00:00Z"
}
```

---

### `PATCH /api/notifications/preferences/`

All fields optional.

**Request body:**
```json
{ "fire_alerts": true, "resolved_alerts": false, "sound_enabled": true }
```

**Response `200`:**
```json
{ "message": "Preferences updated.", "prefs": { "fire_alerts": true, "resolved_alerts": false, "false_alarm_alerts": false, "sound_enabled": true } }
```

---

### `POST /api/notifications/test-push/`

Development helper — sends a single test notification.

**Request body** (optional — defaults to the user's most recent active token):
```json
{ "token": "fcm_token_string" }
```

**Response `200` — success:**
```json
{ "status": "sent", "message_id": "projects/your-project/messages/abc123" }
```

**Response `200` — error:**
```json
{ "status": "error", "detail": "..." }
```

---

## AI Service

Base URL: `http://localhost:8001`  
No authentication required. Runs on **FastAPI + Uvicorn**.

---

### `GET /`

Health check.

**Response `200`:** `{ "message": "ok" }`

---

### `GET /status`

**Response `200`:** `{ "total_cameras": 12, "online": 11 }`

---

### `GET /cameras`

**Response `200`:**
```json
[
  { "name": "Main Entrance", "status": "live" },
  { "name": "Warehouse B", "status": "live" }
]
```

---

### `POST /predict`

Run YOLOv8 inference on an image frame.

**Content-Type:** `multipart/form-data`

| Parameter | Type | Required | Description |
| :--- | :--- | :--- | :--- |
| `file` | File | ✓ | JPEG / PNG image |
| `camera_id` | int (query) | — | Camera DB id (default `1`) |

```bash
curl -X POST http://localhost:8001/predict \
  -F "file=@frame.jpg" \
  -F "camera_id=1"
```

**Response `200`:**
```json
{
  "event_type": "fire",
  "confidence": 87.34,
  "detections": [
    { "label": "fire",  "confidence": 87.34, "x1": 120.5, "y1": 80.2,  "x2": 340.1, "y2": 260.9 },
    { "label": "smoke", "confidence": 72.15, "x1": 95.0,  "y1": 50.0,  "x2": 400.0, "y2": 300.0 }
  ]
}
```

| Field | Type | Values |
| :--- | :--- | :--- |
| `event_type` | string | `"fire"` · `"smoke"` · `"none"` |
| `confidence` | float | 0 – 100 |
| `detections` | array | one entry per detected object |

> **Side effect:** if `event_type != "none"` and `confidence > 50`, the service automatically calls `POST /api/events/` on the Django backend.

**Error `400`:** Non-image upload or corrupt file.

---

## Common Error Shapes

| HTTP | Body | When |
| :--- | :--- | :--- |
| `400` | `{ "field": ["message"] }` | Validation failure |
| `400` | `{ "error": "..." }` | Missing required field |
| `401` | `{ "error": "Invalid credentials." }` | Bad login |
| `403` | (DRF default) | Authenticated but not authorized |
| `404` | `{ "error": "... not found." }` | Object does not exist |

---

*Last updated: May 2026 — matches Django 5.2 / DRF 3.17 implementation.*
