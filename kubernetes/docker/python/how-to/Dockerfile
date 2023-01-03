FROM python:3.9-alpine
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt

# python virtual env
RUN python -m venv /py
RUN /py/bin/pip install -r /requirements.txt

# COPY entry point
COPY ./scripts/run-python.sh /scripts/run.sh
RUN chmod +x /scripts/run.sh

# Create user to run django project
RUN adduser --disabled-password --no-create-home app
USER app

# COPY django source code to container
COPY ./app /app

# set virtual python to default bash
ENV PATH="/py/bin:$PATH"

WORKDIR /app

EXPOSE 8000

CMD ["/scripts/run.sh"]
