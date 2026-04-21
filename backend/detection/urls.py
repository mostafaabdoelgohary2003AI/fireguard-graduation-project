from django.urls import path
from .views import proxy_predict

urlpatterns = [
    path("predict/", proxy_predict, name="proxy_predict"),
]
