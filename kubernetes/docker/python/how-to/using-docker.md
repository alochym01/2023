# Django with Docker

## Create folder structure

1. Create app folder - `mkdir app`

## Create Dockerfile

1. Create django packages dependance - `vi requirements.txt`

   ```bash
   Django>=3.2.3,<3.3
   ```

1. Create Docker entry point file to run django project

   ```bash
   #!/bin/sh
   uwsgi --http :8000 --workers 1 --master --enable-threads --module app.wsgi
   ```

1. Create Dockerfile with python alpine

   ```bash
   FROM python:3.9-alpine

   # copy django packages dependance
   COPY ./requirements.txt /requirements.txt

   # create python virtual environments
   RUN python -m venv /py

   # python install all packages.
   RUN /py/bin/pip install -r /requirements.txt

   # create user to run django project
   RUN adduser --disabled-password --no-create-home app

   # copy all source code to container
   COPY ./app /app

   # copy entry point to run django project
   COPY ./scripts /scripts
   # RUN chmod +x /scripts/run.sh

   # change to current working directory
   WORKDIR /app

   EXPOSE 8000

   # add python virtual environments
   ENV PATH="/py/bin:$PATH"

   USER app

   # Entry point to start django project - python run server ...
   CMD ["/scripts/run-python.sh"]
   # Entry point to start django project - uwsgi run server ...
   # CMD ["/scripts/run-uwsgi.sh"]
   ```

## Create Docker-compose file

1. docker-compose.yaml file

   ```yml
   version: "3"
   services:
     app:
       image: alochym:0.1 # set image:version
       build:
         context: .
       ports:
         - "8000:8000"
       volumes:
         - ./app:/app
       command: >
         sh -c "python manage.py runserver 0.0.0.0:8000"
   ```

## Development Steps

### Using Docker CLI

1. Create Django Project - `docker-compose run --rm app sh -c "django-admin startproject app ."`
1. edit the settings.py file
1. Create Django App - `docker-compose run --rm app sh -c "python manage.py startapp core"`

### Build Docker Images

1. `docker build -f Dockerfile -t alochym-django:0.1 .`
1. `docker build -f Dockerfile-uWSGI -t alochym-django:0.1 .`
1. check images - `docker images`
1. Run docker with image - `docker run -d -p 8000:8000 alochym-django:0.1`
