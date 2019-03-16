FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

#CMD [ "python", "./run.py" ]
# run app located in test.py module (in test.py directory)
# gunicorn -k flask_sockets.worker test:app

# Start gunicorn
#CMD ["gunicorn", "--config", "./gunicorn_config.py", "run:app"]
CMD [ "gunicorn", "-b", ":80", "-k", "flask_sockets.worker", "run:app" ]