#!/bin/sh

uwsgi --http :8000 --workers 1 --master --enable-threads --module app.wsgi
