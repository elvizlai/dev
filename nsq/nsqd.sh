#!/bin/bash
param="nsqd-dev"

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
        -p 127.0.0.1:4150:4150 \
        --name $param \
        --link=nsql-dev \
        nsqio/nsq /nsqd -lookupd-tcp-address=nsql-dev:4160
fi
