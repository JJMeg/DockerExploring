From ubuntu
RUN apt-get update && apt-get install -y libssl1.0.0 libssl-dev

FROM golang:1.12.9

COPY mongodb-linux-x86_64-3.6.13/bin/mongod /usr/local/bin/
RUN mkdir -p /data/db

ENV PATH="/usr/bin/gcc:${PATH}"

WORKDIR /ws

CMD mongod --fork --logpath /var/log/mongodb.log && go test -mod=vendor ./...
