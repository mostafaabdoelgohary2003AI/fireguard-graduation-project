from __future__ import annotations

import cv2
import numpy as np
from ultralytics import YOLO

# Classes defined in the trained model's data.yaml: ['smoke', 'fire']
TARGET_CLASSES = {"smoke", "fire"}

MODEL_PATH = "model/best.pt"
CONF_THRESHOLD = 0.5
INPUT_SIZE = 640


def load_model() -> YOLO:
    model = YOLO(MODEL_PATH)
    # Warm up the model so the first real request is not slow
    dummy = np.zeros((INPUT_SIZE, INPUT_SIZE, 3), dtype=np.uint8)
    model(dummy, conf=CONF_THRESHOLD, verbose=False)
    return model


def run_inference(model: YOLO, image: np.ndarray) -> tuple[str, float, list[dict]]:
    results = model(image, conf=CONF_THRESHOLD, verbose=False)
    best_label, best_conf = "none", 0.0
    detections = []

    for result in results:
        boxes = result.boxes
        if boxes is None or len(boxes) == 0:
            continue
        for box in boxes:
            label = model.names[int(box.cls.item())].lower()
            if label not in TARGET_CLASSES:
                continue
            conf = float(box.conf.item())
            x1, y1, x2, y2 = [round(v, 2) for v in box.xyxy[0].tolist()]
            detections.append({
                "label": label,
                "confidence": round(conf * 100, 2),
                "x1": x1,
                "y1": y1,
                "x2": x2,
                "y2": y2,
            })
            if conf > best_conf:
                best_label, best_conf = label, conf

    if best_label == "none" or best_conf < CONF_THRESHOLD:
        return "none", 0.0, detections

    confidence = round(best_conf * 100, 2)
    return best_label, confidence, detections
