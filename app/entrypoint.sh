#!/bin/bash
set -e


cd ${PROJECT_DIR}
python3 -m venv ${WSGI_VENV}

${WSGI_VENV}/bin/pip install wheel
${WSGI_VENV}/bin/pip install -r requirements.txt
${WSGI_VENV}/bin/mc -e docker manage "migrate --no-input"
${WSGI_VENV}/bin/mc -e docker loaddata
${WSGI_VENV}/bin/mc -e docker manage "rebuild_index --noinput"
${WSGI_VENV}/bin/mc -e docker manage "generate_icons --no-input --clean --force"

exec ${WSGI_VENV}/bin/python manage.py runserver 0.0.0.0:8000
