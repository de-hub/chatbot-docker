chatbot-docker
==============

This repository contains files for a [Docker](https://www.docker.com/) setup of https://github.com/de-hub/chatbot.

Prerequisites
-------------

Besides having docker installed, this setup expects the [chatbot](https://github.com/de-hub/chatbot) repository cloned in the directory.

```
git clone https://github.com/de-hub/chatbot
```

Build
-----

The docker image can be build using:

```
docker build . -t chatbot
```

Run
---

The docker image can be run for a test (with SQLite) using:

```
docker run --name chatbot -p 127.0.0.1:8000:8000/tcp \
    -e SECRET_KEY=notverysecret -e DATABASE="sqlite:///chatbot.sqlite3" -e DEBUG=True \
    -v "$(pwd)/chatbot":/chatbot
    chatbot python manage.py runserver 0.0.0.0:8000
```

The usual steps to setup the database can be executed using `docker exec -it`:

```
docker exec -it chatbot python manage.py migrate
docker exec -it chatbot python manage.py collectstatic
docker exec -it chatbot python manage.py createsuperuser
```

Compose
-------

To start a production environment (NGINX, PostgreSQL) use:

```
docker-compose up
```

For a development environment (with PostgreSQL) use:

```
docker-compose -f docker-compose.dev.yml up
```

As before, the usual steps to setup the database can be executed using `docker exec -it`:

```
docker exec -it chatbot-docker_chatbot_1 python manage.py migrate
docker exec -it chatbot-docker_chatbot_1 python manage.py collectstatic
docker exec -it chatbot-docker_chatbot_1 python manage.py createsuperuser
```
