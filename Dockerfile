FROM phusion/baseimage:0.9.16

MAINTAINER Andy Grant <andy.a.grant@gmail.com>

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
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

ENV RETHINKDB_VERSION 2.0.2

RUN wget http://download.rethinkdb.com/dist/rethinkdb-$RETHINKDB_VERSION.tgz && \
    tar xf rethinkdb-$RETHINKDB_VERSION.tgz && \
    cd rethinkdb-$RETHINKDB_VERSION && \
    ./configure --allow-fetch && \
    make && \
    make install

RUN groupadd -r rethinkdb && useradd -d /var/lib/rethinkdb -g rethinkdb rethinkdb

RUN rm -rf /var/lib/apt/lists/*

VOLUME ["/data"]

WORKDIR /data

RUN mkdir /etc/service/rethinkdb
ADD rethinkdb.sh /etc/service/rethinkdb/run
ADD rethinkdb.conf /rethinkdb.conf

EXPOSE 8080
EXPOSE 28015
EXPOSE 29015

CMD ["/sbin/my_init", "--quiet"]

