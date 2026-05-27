# FireGuard — Firebase Setup Guide

> Complete guide for configuring Firebase Cloud Messaging (FCM) across the backend and Flutter app.

---

## Table of Contents

1. [Overview](#1-overview)
2. [Firebase Project Setup](#2-firebase-project-setup)
3. [Backend Configuration](#3-backend-configuration)
4. [Flutter Configuration](#4-flutter-configuration)
5. [Notification Channels](#5-notification-channels)
6. [Alarm Sound Asset](#6-alarm-sound-asset)
7. [Testing Push Notifications](#7-testing-push-notifications)
8. [Troubleshooting](#8-troubleshooting)

---

## 1. Overview

Firebase powers the **real-time push notification pipeline** in FireGuard. When the AI service detects fire or smoke, the Django backend dispatches alerts to all registered mobile devices via Firebase Cloud Messaging.

> **Graceful degradation:** If Firebase credentials are missing, the backend logs a warning and the app keeps working — push delivery is simply skipped. All other functionality (authentication, events, cameras) remains unaffected.

---

## 2. Firebase Project Setup

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or select an existing one.
3. Enable **Cloud Messaging** in the project settings.
4. Register both **Android** and **iOS** apps under **Project Settings → Your apps**.

---

## 3. Backend Configuration

### 3.1 Service Account Key

1. Navigate to **Firebase Console → Project Settings → Service Accounts**.
2. Click **Generate new private key** → download the JSON file.
3. Place it at:
   ```
   backend/firebase_credentials.json
   ```
4. (Optional) Override the path via environment variable:
   ```bash
   export FIREBASE_CREDENTIALS_PATH=/absolute/path/to/firebase_credentials.json
   ```

### 3.2 How Firebase Initializes

Firebase is initialized in `notifications/apps.py → AppConfig.ready()`:

```python
from fireguard.firebase import initialize_firebase
initialize_firebase()
```

- The initialization function is **idempotent** — safe to call multiple times.
- On success, logs: `[Firebase] Initialized successfully.`
- On failure (e.g., missing file), logs: `[Firebase] Initialization failed: ...`

### 3.3 FCM Dispatch Functions

Located in `notifications/fcm.py`:

| Function | Purpose |
| :--- | :--- |
| `send_fire_alert_to_all(event)` | Multicast fire/smoke alert to all opted-in devices |
| `send_resolved_alert(event)` | Notify devices that an event was resolved |
| `send_test_push(token)` | Send a test notification to a single device token |

---

## 4. Flutter Configuration

### 4.1 Platform Config Files

| Platform | File | Location |
| :--- | :--- | :--- |
| Android | `google-services.json` | `frontend/android/app/` |
| iOS | `GoogleService-Info.plist` | `frontend/ios/Runner/` |

Both files are downloaded from **Firebase Console → Project Settings → Your apps**.

### 4.2 FCM Token Registration

The Flutter app handles FCM token lifecycle automatically:

- **On login/register:** Calls `POST /api/notifications/register-device/` with the FCM token
- **On logout:** Calls `DELETE /api/notifications/unregister-device/`
- No manual handling required — see `core/services/notification_service.dart`

### 4.3 Firebase Dependencies (in `pubspec.yaml`)

```yaml
firebase_core: ^3.13.0
firebase_messaging: ^15.2.0
flutter_local_notifications: ^18.0.0
```

---

## 5. Notification Channels

### Android

| Property | Value |
| :--- | :--- |
| Channel ID | `alerts` |
| Importance | High |
| LED color | Red |
| Vibration | Enabled |
| Sound | Default |
| `fullScreenIntent` | Enabled |

> The channel ID is hardcoded in both `notifications/fcm.py` (backend) and `notification_service.dart` (Flutter) — they **must match**.

### iOS

| Property | Value |
| :--- | :--- |
| APNS priority | `10` (immediate) |
| Interruption level | `critical` |
| Behavior | Bypasses Do Not Disturb |

---

## 6. Alarm Sound Asset

For the full emergency UX (siren + vibration + full-screen alert), place a royalty-free MP3 siren at:

```
frontend/assets/sounds/alarm.mp3
```

If missing, `AlarmService` silently falls back to **vibration only**.

---

## 7. Testing Push Notifications

### 7.1 Using the Test Endpoint

```bash
# Send a test push to a specific FCM token
curl -X POST http://localhost:8000/api/notifications/test-push/ \
  -H "Authorization: Token <your_auth_token>" \
  -H "Content-Type: application/json" \
  -d '{"token":"<fcm_device_token>"}'
```

**Response (success):**
```json
{ "status": "sent", "message_id": "projects/your-project/messages/abc123" }
```

### 7.2 End-to-End Test

1. Start the backend and AI service.
2. Log in to the Flutter app (this auto-registers the FCM token).
3. Confirm the device token exists:
   ```bash
   curl http://localhost:8000/api/notifications/preferences/ \
     -H "Authorization: Token <token>"
   ```
4. Trigger a detection via the AI service or use the **"SIMULATE ALERT (Demo)"** button on the Flutter Home screen.
5. Verify the push notification arrives on the device.

---

## 8. Troubleshooting

| Symptom | Cause | Fix |
| :--- | :--- | :--- |
| `[Firebase] Initialization failed` in Django logs | Missing or invalid `firebase_credentials.json` | Verify the file exists and is valid JSON with a `private_key` field |
| Push not delivered, no error | User's `fire_alerts` preference is `false` | Check `NotificationPreference` table or `GET /api/notifications/preferences/` |
| Push not delivered, `InvalidRegistration` error | Stale FCM token | Re-login on the mobile app to refresh the token |
| Push works on Android but not iOS | Missing `GoogleService-Info.plist` or APNS not configured | Add the plist and enable Push Notifications capability in Xcode |
| PythonAnywhere: push never fires | Free-tier blocks outbound HTTP | Use a paid tier or deploy the backend elsewhere |

---

*This document is part of the FireGuard graduation project — May 2026.*
