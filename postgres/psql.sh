#!/bin/bash
param="postgres-dev"

docker exec -it $param psql -U postgres
