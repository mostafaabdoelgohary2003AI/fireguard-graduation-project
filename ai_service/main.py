import logging

from fastapi import FastAPI, File, HTTPException, Query, UploadFile

from inference import FireDetector

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s: %(message)s",
)
logger = logging.getLogger(__name__)

app = FastAPI()
detector = FireDetector()

CONFIDENCE_THRESHOLD = 50.0


@app.get("/")
def root():
    return {"message": "ok"}


@app.get("/status")
def get_status():
    return {"total_cameras": 12, "online": 11}


@app.get("/cameras")
def get_cameras():
    return [
        {"name": "Main Entrance", "status": "live"},
        {"name": "Warehouse B", "status": "live"},
    ]


@app.post("/predict")
async def predict(
    file: UploadFile = File(...),
    camera_id: int = Query(default=1, description="Database ID of the camera sending this frame"),
):
    if not file.content_type.startswith("image/"):
        raise HTTPException(status_code=400, detail="Uploaded file must be an image.")

    try:
        event_type, confidence, detections = detector.predict(await file.read())
    except ValueError as exc:
        raise HTTPException(status_code=400, detail=str(exc))

    logger.info(
        "Prediction: camera=%s event_type=%s confidence=%s detections=%d",
        camera_id, event_type, confidence, len(detections),
    )

    if event_type != "none" and confidence > CONFIDENCE_THRESHOLD:
        detector.notify_backend(camera=camera_id, event_type=event_type, confidence=confidence)

    return {"event_type": event_type, "confidence": confidence, "detections": detections}
