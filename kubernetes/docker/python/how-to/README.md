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
   python manage.py runserver 0.0.0.0:8000
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

   # copy entry point to run django project
   COPY ./scripts/run-python.sh /scripts/run.sh
   RUN chmod +x /scripts/run.sh

   # copy all source code to container
   COPY ./app /app

   # change to current working directory
   WORKDIR /app

   EXPOSE 8000

   # create user to run django project
   RUN adduser --disabled-password --no-create-home app
   USER app

   # add python virtual environments
   ENV PATH="/py/bin:$PATH"

   # Entry point to start django project
   CMD ["/scripts/run.sh"]
   ```

## Create Docker-compose file

1. docker-compose.yaml file - using for development

   ```yml
   version: "3"
   services:
     app:
       # image: alochym:0.1 # set image:version
       build:
         context: .
       ports:
         - "8000:8000"
       volumes:
         - ./app:/app
       command: >
         sh -c "python manage.py runserver 0.0.0.0:8000"
   ```

1. `docker-compose up`.

## Development Steps

### Using Docker CLI

1. Create Django Project - `docker-compose run --rm app sh -c "django-admin startproject app ."`
1. Edit the settings.py file
1. Create Django App - `docker-compose run --rm app sh -c "python manage.py startapp core"`

### Build Docker Images

1. Docker image running with python - `docker build -f Dockerfile -t alochym-django:0.1 .`
1. Docker image running with uWSGI - `docker build -f Dockerfile-uWSGI -t alochym-django:0.1 .`
1. check images - `docker images`
1. Run docker with image - `docker run -d -p 8000:8000 alochym-django:0.1`
