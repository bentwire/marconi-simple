#!/bin/bash 
# Create a place for mongo storage
if [ ! -d /data/db ]; then
    rm -rf /data/db
    mkdir -p /data/db
fi

# Start mongo
/usr/bin/mongod --fork --syslog

# Start memcached
/usr/bin/memcached -d -u memcache

# Wait for things to settle
sleep 10

# Start marconi
gunicorn -b 0.0.0.0:80 marconi.queues.transport.wsgi.app:app
