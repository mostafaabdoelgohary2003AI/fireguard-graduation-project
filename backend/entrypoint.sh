#!/bin/sh

python manage.py migrate --noinput

if [ -n "$DJANGO_SUPERUSER_USERNAME" ]; then
  python manage.py createsuperuser --noinput \
    --username "$DJANGO_SUPERUSER_USERNAME" \
    --email "${DJANGO_SUPERUSER_EMAIL:-admin@example.com}" \
    2>/dev/null || echo "Superuser already exists, skipping."
fi

exec python manage.py runserver 0.0.0.0:8000
