#!/bin/bash

TAG=hadoocker/base:centos62

/bin/cp ../hadoop-client/hadoop-client.sh .

docker rmi $TAG
docker build  --force-rm --no-cache -t $TAG .
