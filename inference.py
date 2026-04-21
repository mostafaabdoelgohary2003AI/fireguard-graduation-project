import io
import logging

import numpy as np
import requests
from PIL import Image, UnidentifiedImageError

from model import load_model, run_inference

logger = logging.getLogger(__name__)

DJANGO_BACKEND_URL = "http://backend:8000"


class FireDetector:
    def __init__(self):
        self._model = load_model()

    def predict(self, image_bytes: bytes) -> tuple[str, float, list[dict]]:
        try:
            image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
        except UnidentifiedImageError as exc:
            raise ValueError("Could not decode image.") from exc

        return run_inference(self._model, np.array(image))

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
