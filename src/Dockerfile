FROM python:3.9-buster

RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/aluraflix

COPY requirements.txt manage.py entrypoint.sh /opt/app/
COPY setup /opt/app/setup/
COPY entrypoint.sh /opt/app/
COPY aluraflix /opt/app/aluraflix/

WORKDIR /opt/app

RUN pip install -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]