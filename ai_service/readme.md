# AI Service

This directory contains the AI inference service used by FireGuard.

## Model Weights

The trained YOLO model weights (`best.pt`) are **not included** in this repository.

To run the AI service, provide your own compatible YOLO model and place it in this directory as:

```text
ai_service/best.pt
```

## Running

```bash
pip install -r requirements.txt
python camera.py
```

## Notes

- The model weights were intentionally excluded from this repository.
- The repository only includes the inference pipeline and supporting code.
