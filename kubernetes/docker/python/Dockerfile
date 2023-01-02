FROM python:3.9-alpine3.13
LABEL maintainer="Alochym"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt

RUN adduser --disabled-password --no-create-home app
# RUN mkdir -p /vol/web/static
# RUN mkdir -p /vol/web/media
# RUN chown -R app:app /vol
# RUN chmod -R 755 /vol

# build postgresql
# RUN apk add --update --no-cache postgresql-client

# build uwsgi
# RUN apk add --update --no-cache --virtual .tmp-deps build-base postgresql-dev musl-dev linux-headers

RUN apk add --update --no-cache --virtual .tmp-deps build-base musl-dev linux-headers
RUN python -m venv /py
RUN /py/bin/pip install --upgrade pip
RUN /py/bin/pip install -r /requirements.txt --use-pep517
RUN rm -rf /tmp
RUN apk del .tmp-deps

ENV PATH="/py/bin:$PATH"

COPY ./app /app

COPY ./scripts /scripts
RUN chmod +x /scripts/run.sh

WORKDIR /app

EXPOSE 8000

USER app

CMD ["/scripts/run.sh"]