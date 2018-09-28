FROM resin/armv7hf-python:3.6-slim

RUN [ "cross-build-start" ]
# RUN apk add gcc python3-dev libc-dev libffi-dev openssl-dev --update

RUN apt-get update && apt-get install -y gcc libc-dev python3-dev libffi-dev libssl-dev && rm -rf /var/lib/apt/lists/*
RUN pip install gevent==1.2.2

EXPOSE 5557/tcp

COPY . .
RUN pip install -e ./

ENV XBOX_IP False

RUN [ "cross-build-end" ]
CMD [ "xbox-rest-server" ]
