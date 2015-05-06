#!/bin/bash

chown rethinkdb:rethinkdb /data
chmod 0755 /data

exec /sbin/setuser rethinkdb /usr/local/bin/rethinkdb --config-file /rethinkdb.conf

