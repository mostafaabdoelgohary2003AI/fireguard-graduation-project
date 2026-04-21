#!/bin/sh

echo "Waiting for PostgreSQL..."
until python -c "
import os, socket
s = socket.create_connection((os.environ['DB_HOST'], int(os.environ.get('DB_PORT', 5432))), timeout=1)
s.close()
" 2>/dev/null; do
  sleep 1
done

echo "PostgreSQL is ready."

python manage.py migrate --noinput

exec python manage.py runserver 0.0.0.0:8000
