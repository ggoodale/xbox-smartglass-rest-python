FROM python:3.6-alpine

EXPOSE 5557/tcp

RUN apk add gcc python3-dev libc-dev libffi-dev openssl-dev --update
RUN pip install gevent==1.2.2

COPY . .

RUN pip install -e ./

ENV XBOX_IP False
RUN ["xbox-auth-via-browser"]
CMD ["xbox-rest-server"]
