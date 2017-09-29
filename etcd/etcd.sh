#!/bin/bash
param="etcd-dev"

if source `dirname $0`/../stop.sh
then
    echo "$param stopped and cleanup"
elif docker ps | grep $param > /dev/null 2>&1
then
    echo "$param already started"
elif docker ps -a | grep $param | grep "Exited" > /dev/null 2>&1
then
    echo "$param exist but stopped, start it"
    docker ps -a | grep $param | grep "Exited" | awk '{print $1}' | xargs docker start > /dev/null 2>&1
else
    docker run -it -d \
        -p 127.0.0.1:2379:2379 \
        -p 127.0.0.1:4001:4001 \
        --name $param \
        gcr.io/etcd-development/etcd etcd \
        --listen-client-urls 'http://0.0.0.0:2379,http://0.0.0.0:4001' \
        --advertise-client-urls 'http://0.0.0.0:2379,http://0.0.0.0:4001' \
        --debug=true
fi
