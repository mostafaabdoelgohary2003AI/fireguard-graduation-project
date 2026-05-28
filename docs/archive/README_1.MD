## End-to-End Local Runbook

---

### 1 — Run the AI Service

```bash
# On the AI laptop, inside the project root
cd ai_service

# Install deps (first time only)
pip install -r requirements.txt

# Start the service
uvicorn main:app --host 0.0.0.0 --port 8001
```

Confirm it started: `http://localhost:8001/` → `{"message":"ok"}`

---

### 2 — Get the AI Laptop's LAN IP

**Windows:**
```powershell
ipconfig
# Look for "IPv4 Address" under your WiFi adapter
# e.g. 192.168.1.105
```

**macOS/Linux:**
```bash
ifconfig | grep "inet " | grep -v 127
# e.g. inet 192.168.1.105
```

Test from any other device on the same WiFi:
```
http://192.168.1.105:8001/
```
Must return `{"message":"ok"}`. If it doesn't, the firewall is blocking port 8001 (see error fixes below).

---

### 3 — Run Flutter with AI URL

```bash
cd frontend/fire_guard-main

flutter run --dart-define=AI_BASE_URL=http://192.168.1.105:8001
```

> Replace `192.168.1.105` with the actual IP from step 2 every time the AI laptop's IP changes.

---

### 4 — Correct AI Endpoint

```
POST http://192.168.1.105:8001/predict?camera_id=1
Content-Type: multipart/form-data
```

Field name for the image: **`file`**

---

### 5 — Request / Response Format

**Request** (multipart form):
```
field name : file
value      : <image file bytes>
query param: camera_id=1   (integer, must exist in backend DB)
```

**Response** (JSON):
```json
{
  "event_type": "fire",       // "fire" | "smoke" | "none"
  "confidence": 87.43,        // float, 0–100
  "detections": [
    {
      "label": "fire",
      "confidence": 87.43,
      "x1": 120.5, "y1": 80.2,
      "x2": 340.1, "y2": 290.7
    }
  ]
}
```

When `event_type != "none"` and `confidence > 50`, the AI automatically fires:

```
POST https://bodareda0001.pythonanywhere.com/api/events/
Content-Type: application/json

{
  "camera": 1,
  "event_type": "fire",
  "ai_confidence": 87.43
}
```

---

### 6 — Verify AI → Backend is Working

**Step 6a — Call `/predict` directly with curl:**
```bash
curl -X POST "http://192.168.1.105:8001/predict?camera_id=1" \
  -F "file=@/path/to/test_image.jpg"
```

**Step 6b — Check backend received the event:**
```bash
curl -X GET "https://bodareda0001.pythonanywhere.com/api/events/" \
  -H "Authorization: Token <your_token>"
```
A new event with `camera=1` should appear.

**Step 6c — Check AI service logs** (terminal where uvicorn is running):
```
INFO  Prediction: camera=1 event_type=fire confidence=87.43 detections=1
INFO  Backend notified: camera=1 event_type=fire confidence=87.43
```
If you see `WARNING  Failed to notify Django backend` instead, the AI→backend call failed.

**Step 6d — Verify camera ID 1 exists in backend:**
```bash
curl "https://bodareda0001.pythonanywhere.com/api/cameras/cameras/" \
  -H "Authorization: Token <your_token>"
```
If camera with `id=1` is missing or has `"status": "offline"`, the backend will reject the event with 400.

---

### 7 — Real-World Errors and Quick Fixes

| Error | Symptom | Fix |
|-------|---------|-----|
| **Wrong IP** | Flutter can't reach AI, connection refused | Re-run `ipconfig`, update `--dart-define=AI_BASE_URL=http://<new_ip>:8001` |
| **Different WiFi** | Connection timeout or refused | Both laptop and device must be on the same WiFi network |
| **Firewall blocking 8001** | LAN test from step 2 times out | Windows: Allow port 8001 in Windows Defender Firewall → Inbound Rules |
| **401 on backend calls** | Flutter gets 401 after login | Login first to get a token; confirm `api_service.dart` sends `Authorization: Token <token>` (not `Bearer`) |
| **400 on /api/events/** | AI log shows `Failed to notify Django backend` | Camera `id=1` doesn't exist or is `offline` in backend DB — create it via Django admin |
| **Backend URL mismatch** | AI events go to wrong server | Confirm `ai_service/inference.py` env var `DJANGO_BACKEND_URL` is unset or set to `https://bodareda0001.pythonanywhere.com` |
| **Double-slash 404** | `//api/events/` returns 404 | `DJANGO_BACKEND_URL` must have **no trailing slash** — already fixed in code |
| **model/best.pt missing** | AI crashes on startup with `FileNotFoundError` | Place the trained YOLO model file at `ai_service/model/best.pt` |

---

### Quick Sanity Checklist Before Testing

```
[ ] uvicorn running on AI laptop, bound to 0.0.0.0:8001
[ ] http://<LAN_IP>:8001/ returns {"message":"ok"} from another device
[ ] Flutter launched with --dart-define=AI_BASE_URL=http://<LAN_IP>:8001
[ ] Camera id=1 exists and is NOT "offline" in backend
[ ] DJANGO_BACKEND_URL in AI env = https://bodareda0001.pythonanywhere.com (no trailing slash)
[ ] Flutter token header = "Token <value>" (not "Bearer")
[ ] Both devices on same WiFi
```