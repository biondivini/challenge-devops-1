#!/bin/bash
python manage.py migrate
python manage.py loaddata ./aluraflix/fixtures/programas_iniciais.json
python manage.py createsuperuser --no-input
python manage.py runserver 0.0.0.0:8000