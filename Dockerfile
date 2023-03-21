FROM python:3.11.2

ENV PYTHONUNBUFFERED=1

WORKDIR /project

COPY requirements.txt requirements.txt
RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . /project/
CMD gunicorn server.wsgi:application --bind 0.0.0.0:8000
EXPOSE 8000
