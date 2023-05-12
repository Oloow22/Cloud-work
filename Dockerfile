FROM python:3.11-alpine

RUN mkdir /code

WORKDIR /code

# Python dependencies
COPY docker/requirements.txt /code
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8000

# Project files
COPY . /code/

# Run migrations, and load the database with fixtures
RUN python manage.py migrate && python manage.py loaddata users posts comments

ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
