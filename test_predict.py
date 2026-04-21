"""
Quick test script for the FastAPI /predict endpoint.

Usage:
    # Test with an auto-generated blank image (no real image needed):
    python test_predict.py

    # Test with a real image file:
    python test_predict.py path/to/image.jpg

    # Test against a different host:
    python test_predict.py path/to/image.jpg http://localhost:8001
"""

import sys
import os

import requests

ENDPOINT = "http://localhost:8001"


def make_test_image():
    """Return JPEG bytes for a small blank image without requiring any file on disk."""
    try:
        import cv2
        import numpy as np
        frame = np.zeros((64, 64, 3), dtype="uint8")
        _, buf = cv2.imencode(".jpg", frame)
        return buf.tobytes(), "generated_blank.jpg"
    except ImportError:
        # Minimal 1x1 white JPEG (valid JFIF, no dependencies)
        jpeg_1x1 = (
            b"\xff\xd8\xff\xe0\x00\x10JFIF\x00\x01\x01\x00\x00\x01\x00\x01\x00\x00"
            b"\xff\xdb\x00C\x00\x08\x06\x06\x07\x06\x05\x08\x07\x07\x07\t\t"
            b"\x08\n\x0c\x14\r\x0c\x0b\x0b\x0c\x19\x12\x13\x0f\x14\x1d\x1a"
            b"\x1f\x1e\x1d\x1a\x1c\x1c $.' \",#\x1c\x1c(7),01444\x1f'9=82<.342\x1e"
            b"\xff\xc0\x00\x0b\x08\x00\x01\x00\x01\x01\x01\x11\x00"
            b"\xff\xc4\x00\x1f\x00\x00\x01\x05\x01\x01\x01\x01\x01\x01\x00\x00"
            b"\x00\x00\x00\x00\x00\x00\x01\x02\x03\x04\x05\x06\x07\x08\t\n\x0b"
            b"\xff\xc4\x00\xb5\x10\x00\x02\x01\x03\x03\x02\x04\x03\x05\x05\x04"
            b"\x04\x00\x00\x01}\x01\x02\x03\x00\x04\x11\x05\x12!1A\x06\x13Qa"
            b"\x07\"q\x142\x81\x91\xa1\x08#B\xb1\xc1\x15R\xd1\xf0$3br"
            b"\x82\t\n\x16\x17\x18\x19\x1a%&'()*456789:CDEFGHIJ"
            b"STUVWXYZ\xff\xda\x00\x08\x01\x01\x00\x00?\x00\xfb\xd4P\x00\x00\x00\xff\xd9"
        )
        return jpeg_1x1, "generated_blank.jpg"


def load_image(path):
    if not os.path.isfile(path):
        print(f"[ERROR] File not found: {path}")
        sys.exit(1)
    with open(path, "rb") as f:
        return f.read(), os.path.basename(path)


def check_health(base_url):
    try:
        r = requests.get(f"{base_url}/", timeout=5)
        r.raise_for_status()
        print(f"[OK]    Server reachable at {base_url}")
    except requests.ConnectionError:
        print(f"[ERROR] Cannot connect to {base_url}")
        print("        Is the AI service running?  docker compose up ai_service")
        sys.exit(1)
    except requests.Timeout:
        print(f"[ERROR] Connection timed out: {base_url}")
        sys.exit(1)
    except requests.HTTPError as e:
        print(f"[WARN]  Health check returned: {e}")


def test_predict(base_url, image_bytes, filename):
    print(f"[INFO]  Sending '{filename}' ({len(image_bytes)} bytes) to {base_url}/predict ...")
    try:
        response = requests.post(
            f"{base_url}/predict",
            files={"file": (filename, image_bytes, "image/jpeg")},
            timeout=10,
        )
    except requests.Timeout:
        print("[ERROR] Request timed out. The server may be overloaded.")
        sys.exit(1)
    except requests.ConnectionError as e:
        print(f"[ERROR] Connection lost during request: {e}")
        sys.exit(1)

    print(f"[INFO]  HTTP status: {response.status_code}")

    if response.status_code == 400:
        print(f"[ERROR] Bad request: {response.json().get('detail', response.text)}")
        sys.exit(1)

    if response.status_code != 200:
        print(f"[ERROR] Unexpected response ({response.status_code}): {response.text}")
        sys.exit(1)

    data = response.json()
    event_type = data.get("event_type", "N/A")
    confidence = data.get("confidence", 0.0)
    detections = data.get("detections", [])

    print()
    print("  Results")
    print("  -------")
    print(f"  event_type  : {event_type}")
    print(f"  confidence  : {confidence}")
    print(f"  detections  : {len(detections)} object(s)")
    print()

    if event_type != "none" and confidence > 50:
        print("  >> FIRE / SMOKE DETECTED")
    else:
        print("  >> No fire detected")


if __name__ == "__main__":
    image_path = sys.argv[1] if len(sys.argv) > 1 else None
    base_url = sys.argv[2] if len(sys.argv) > 2 else ENDPOINT

    if image_path:
        image_bytes, filename = load_image(image_path)
    else:
        print("[INFO]  No image path provided — using auto-generated blank image.")
        image_bytes, filename = make_test_image()

    check_health(base_url)
    test_predict(base_url, image_bytes, filename)
