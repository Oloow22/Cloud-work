FROM python:3.11-alpine

WORKDIR /mysite

# Python dependencies
COPY /requirements.txt /mysite/
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8000

# Project files
COPY ./mysite /mysite/

# Run migrations, and load the database with fixtures
RUN python manage.py migrate && python manage.py loaddata users posts comments

ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
