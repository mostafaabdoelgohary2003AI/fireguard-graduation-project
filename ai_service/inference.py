import logging
import os

import cv2
import numpy as np
import requests

from model import load_model, run_inference

logger = logging.getLogger(__name__)

DJANGO_BACKEND_URL = os.getenv("DJANGO_BACKEND_URL", "https://bodareda0001.pythonanywhere.com")


class FireDetector:
    def __init__(self):
        self._model = load_model()

    def predict(self, image_bytes: bytes) -> tuple[str, float, list[dict]]:
        image = _decode_image(image_bytes)
        return run_inference(self._model, image)

    def notify_backend(self, camera: int, event_type: str, confidence: float) -> None:
        try:
            response = requests.post(
                f"{DJANGO_BACKEND_URL}/api/events/",
                json={"camera": camera, "event_type": event_type, "ai_confidence": confidence},
                timeout=5,
            )
            response.raise_for_status()
            logger.info("Backend notified: camera=%s event_type=%s confidence=%s", camera, event_type, confidence)
        except requests.RequestException as exc:
            logger.warning("Failed to notify Django backend: %s", exc)


def _decode_image(image_bytes: bytes) -> np.ndarray:
    if not image_bytes:
        raise ValueError("Empty image data.")
    buffer = np.frombuffer(image_bytes, dtype=np.uint8)
    image = cv2.imdecode(buffer, cv2.IMREAD_COLOR)
    if image is None:
        raise ValueError("Could not decode image.")
    return cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
