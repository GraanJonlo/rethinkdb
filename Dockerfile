FROM phusion/baseimage:0.9.18

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN apt-get install -y \
    build-essential \
    libboost-all-dev \
    libcurl4-openssl-dev \
    libjemalloc-dev \
    libncurses5-dev \
    libprotobuf-dev \
    m4 \
    protobuf-compiler \
    python \
    wget

RUN rm -rf /var/lib/apt/lists/*

ENV RETHINKDB_VERSION 2.3.4

RUN wget http://download.rethinkdb.com/dist/rethinkdb-$RETHINKDB_VERSION.tgz && \
    tar xf rethinkdb-$RETHINKDB_VERSION.tgz && \
    cd rethinkdb-$RETHINKDB_VERSION && \
    ./configure --allow-fetch && \
    make && \
    make install

RUN groupadd -r rethinkdb && useradd -d /var/lib/rethinkdb -g rethinkdb rethinkdb

RUN rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]
VOLUME ["/var/logs/rethinkdb"]

WORKDIR /data

RUN mkdir /etc/service/rethinkdb
ADD rethinkdb.sh /etc/service/rethinkdb/run

ADD rethinkdb.toml /etc/confd/conf.d/rethinkdb.toml
ADD rethinkdb.conf.tmpl /etc/confd/templates/rethinkdb.conf.tmpl

EXPOSE 8080 28015 29015

CMD ["/sbin/my_init", "--quiet"]