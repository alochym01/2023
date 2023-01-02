#!/bin/sh

# set -e

# ls -la /vol/
# ls -la /vol/web

# whoami

# python manage.py wait_for_db
# python manage.py collectstatic --noinput
# python manage.py migrate

# cd app

# run nginx proxy using --socket
# uwsgi --socket :9000 --workers 1 --master --enable-threads --module app.wsgi
uwsgi --http :8000 --workers 1 --master --enable-threads --module app.wsgi
