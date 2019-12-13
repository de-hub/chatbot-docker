FROM nikolaik/python-nodejs:latest
ENV PYTHONUNBUFFERED 1

ARG ENV=prod

COPY chatbot /chatbot
WORKDIR /chatbot

RUN pip install -r requirements/$ENV.txt
RUN pip install psycopg2-binary

RUN mkdir -p /var/log/gunicorn /var/log/chatbot

CMD gunicorn \
    --bind 0.0.0.0:9000 \
    --access-logfile /var/log/gunicorn/access.log \
    --error-logfile /var/log/gunicorn/error.log \
    config.wsgi:application
