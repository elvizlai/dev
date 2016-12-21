param="redis-dev"

if docker ps | grep $param > /dev/null 2>&1
then
    echo "$param already started"
elif docker ps -a | grep $param | grep "Exited" > /dev/null 2>&1
then
    echo "$param exist but stopped, start it"
    docker ps -a | grep $param | grep "Exited" | awk '{print $1}' | xargs docker start > /dev/null 2>&1
else
    docker run -it -d \
        -p 127.0.0.1:6379:6379 \
        --name $param \
        redis
fi