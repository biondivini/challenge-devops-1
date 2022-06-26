FROM python:3.10-slim-buster

RUN mkdir -p /opt/app

COPY . /opt/app/

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /opt/app

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

ENTRYPOINT [ "/opt/app/entrypoint.sh" ]