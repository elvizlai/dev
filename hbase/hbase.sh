param="hbase-dev"

if [[ $1 == "stop" ]];then
    docker stop $param > /dev/null 2>&1
    docker rm $param > /dev/null 2>&1
    docker volume ls | grep -v DRIVER | awk '{print $2}' |xargs docker volume rm > /dev/null 2>&1
    echo "$param stopped and cleanup"
    exit 0
fi

if docker ps | grep $param > /dev/null 2>&1
then
    echo "$param already started"
elif docker ps -a | grep $param | grep "Exited" > /dev/null 2>&1
then
    echo "$param exist but stopped, start it"
    docker ps -a | grep $param | grep "Exited" | awk '{print $1}' | xargs docker start > /dev/null 2>&1
else
    docker run -d \
    -p 127.0.0.1:9090:9090 \
    --name $param\
    -v `pwd`/entrypoint.sh:/entrypoint.sh \
    harisekhon/hbase
fi
