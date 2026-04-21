from __future__ import annotations

import numpy as np
from ultralytics import YOLO

TARGET_CLASSES = {"fire", "smoke", "spark"}


def load_model() -> YOLO:
    return YOLO("model/best.pt")


def run_inference(model: YOLO, image: np.ndarray) -> tuple[str, float, list[dict]]:
    results = model(image, verbose=False)
    best_label, best_conf = "none", 0.0
    detections = []

    for result in results:
        for box in result.boxes:
            label = model.names[int(box.cls.item())].lower()
            conf = float(box.conf.item())
            if label not in TARGET_CLASSES:
                continue
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

    confidence = round(best_conf * 100, 2) if best_label != "none" else 0.0
    return best_label, confidence, detections
