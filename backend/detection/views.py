import os

import requests
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST

AI_SERVICE_URL = os.environ.get("AI_SERVICE_URL", "http://ai_service:8001")


@csrf_exempt
@require_POST
def proxy_predict(request):
    image = request.FILES.get("file")
    if not image:
        return JsonResponse({"error": "No image file provided."}, status=400)

    try:
        response = requests.post(
            f"{AI_SERVICE_URL}/predict",
            files={"file": (image.name, image.read(), image.content_type)},
            timeout=10,
        )
        return JsonResponse(response.json(), status=response.status_code)
    except requests.RequestException as exc:
        return JsonResponse({"error": f"AI service unavailable: {exc}"}, status=503)
