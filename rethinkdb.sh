#!/bin/bash

/usr/local/bin/confd -onetime -backend env

chown rethinkdb:rethinkdb /data
chown rethinkdb:rethinkdb /var/logs/rethinkdb
chmod 0755 /data
chmod 0755 /var/logs/rethinkdb

exec /sbin/setuser rethinkdb /usr/local/bin/rethinkdb --config-file /rethinkdb.conf
