# Django with Docker

## Install Python and Django

1. Create requirements.txt
2. python -m venv .env
3. source .env/bin/active
4. pip install -r requirements.txt

## Create Django Project

1. source .env/bin/active
2. mkdir app
3. cd app
4. django-admin startproject app .

## Create Django App

1. cd app
2. python manage.py startapp alochym

## Build Docker Images

1. Create Dockerfile
2. Build images - `docker build -f ./Dockerfile -t alochym-django:0.1 .`