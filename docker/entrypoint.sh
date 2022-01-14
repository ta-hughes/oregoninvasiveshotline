#!/bin/bash
set -e


cd ${PROJECT_DIR}

# Bootstrap application if requested
if [[ ${EMCEE_BOOTSTRAP} == "yes" ]]; then
    ${APP_ENV}/bin/python manage.py migrate --noinput
    ${APP_ENV}/bin/python manage.py collectstatic --noinput
    exit 0
fi

# Select the entrypoint given the APP_SERVICE
if [[ ${APP_SERVICE} == "wsgi" ]]; then
    exec ${APP_ENV}/bin/uwsgi \
          --processes ${APP_NUM_PROCS} \
          --module oregoninvasiveshotline.wsgi \
          --http-socket :8000 \
          --http-auto-chunked \
          --http-keepalive \
          --ignore-sigpipe \
          --ignore-write-errors \
          --disable-write-exception
elif [[ ${APP_SERVICE} == "celery" ]]; then
    exec ${APP_ENV}/bin/celery -A oregoninvasiveshotline worker -l INFO
elif [[ ${APP_SERVICE} == "scheduler" ]]; then
    exec ${APP_ENV}/bin/celery -A oregoninvasiveshotline beat -l INFO
elif [[ ${APP_SERVICE} == "test" ]]; then
    ${APP_ENV}/bin/pip install -r requirements-dev.txt
    exec ${APP_ENV}/bin/python manage.py test
fi
