FROM python:3.10.8-bullseye

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
COPY djstripetest djstripetest
COPY app app
COPY manage.py .

RUN pip install --upgrade pip -qq
RUN pip install -r requirements.txt -qq
