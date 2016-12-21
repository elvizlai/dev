#!/bin/bash
param="etcd-dev"

docker exec $param etcdctl "$@"
