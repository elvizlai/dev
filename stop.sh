#!/bin/bash
if [[ $1 == "stop" ]];then
    docker stop $param > /dev/null 2>&1
    docker rm $param > /dev/null 2>&1
    docker volume ls | grep -v DRIVER | awk '{print $2}' |xargs docker volume rm > /dev/null 2>&1
    echo "$param stopped and cleanup"
    exit 0
fi