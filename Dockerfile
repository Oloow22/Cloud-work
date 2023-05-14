FROM python:3.11-alpine

WORKDIR /mysite

# Python dependencies
COPY /requirements.txt /mysite/
RUN pip install --no-cache-dir -r requirements.txt
RUN py manage.py collectstatic --noinput

# Project files
COPY ./mysite /mysite/

# Run migrations, and load the database with fixtures
RUN python manage.py migrate && python manage.py loaddata users posts comments

CMD gunicorn mysite.wsgi:application --bind 0.0.0.0:$PORT
