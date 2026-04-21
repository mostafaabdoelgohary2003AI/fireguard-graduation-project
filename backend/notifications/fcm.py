import os
import firebase_admin
from firebase_admin import credentials, messaging
from django.conf import settings


# =========================
# Firebase Init (once only)
# =========================
def _get_firebase_app():
    if not firebase_admin._apps:

        path = settings.FIREBASE_CREDENTIALS_PATH

        # 🔥 Safety check
        if not os.path.exists(path):
            raise Exception("Firebase credentials file not found")

        cred = credentials.Certificate(path)
        firebase_admin.initialize_app(cred)

    return firebase_admin.get_app()


# =========================
# 🔥 Fire / Smoke Alert
# =========================
def send_fire_alert_to_all(event):
    """
    Broadcast fire/smoke alert to all active devices
    """
    try:
        _get_firebase_app()

        from notifications.models import FCMDevice

        tokens = list(
            FCMDevice.objects.filter(is_active=True)
            .values_list('token', flat=True)
        )

        if not tokens:
            return {"status": "skipped", "reason": "No active FCM tokens found."}

        # 🔥 dynamic event type
        event_type = getattr(event, "event_type", "fire")

        title = "🔥 Fire Detected!" if event_type == "fire" else "💨 Smoke Detected!"

        zone_name = event.camera.zone.name if event.camera.zone else "Unknown"

        message = messaging.MulticastMessage(
            tokens=tokens,
            notification=messaging.Notification(
                title=title,
                body=f"{event.camera.location} — {event.ai_confidence:.1f}% confidence",
            ),
            data={
                "event_id": str(event.id),
                "camera_id": str(event.camera.id),
                "camera_name": event.camera.name,
                "location": event.camera.location,
                "zone": zone_name,
                "event_type": event_type,
                "ai_confidence": str(event.ai_confidence),
                "type": "fire_alert",
                "detected_at": str(event.detected_at),
            },
            android=messaging.AndroidConfig(
                priority='high',
                notification=messaging.AndroidNotification(
                    sound='default',
                    priority='high',
                    channel_id='fire_alerts',
                ),
            ),
            apns=messaging.APNSConfig(
                payload=messaging.APNSPayload(
                    aps=messaging.Aps(
                        sound='default',
                        badge=1,
                    ),
                ),
            ),
        )

        response = messaging.send_each_for_multicast(message)

        # 🔥 deactivate invalid tokens
        if response.failure_count > 0:
            failed_tokens = [
                tokens[i]
                for i, resp in enumerate(response.responses)
                if not resp.success
            ]
            FCMDevice.objects.filter(token__in=failed_tokens).update(is_active=False)

        return {
            "status": "sent",
            "success_count": response.success_count,
            "failure_count": response.failure_count,
        }

    except Exception as e:
        return {"status": "error", "detail": str(e)}


# =========================
# ✅ Resolved Alert
# =========================
def send_resolved_alert(event):
    """
    Notify users when fire/smoke event is resolved
    """
    try:
        _get_firebase_app()

        from notifications.models import FCMDevice

        tokens = list(
            FCMDevice.objects.filter(is_active=True)
            .values_list('token', flat=True)
        )

        if not tokens:
            return {"status": "skipped"}

        message = messaging.MulticastMessage(
            tokens=tokens,
            notification=messaging.Notification(
                title="✅ Event Resolved",
                body=f"{event.camera.location} has been resolved.",
            ),
            data={
                "event_id": str(event.id),
                "type": "event_resolved",
            },
        )

        response = messaging.send_each_for_multicast(message)

        return {
            "status": "sent",
            "success_count": response.success_count,
        }

    except Exception as e:
        return {"status": "error", "detail": str(e)}