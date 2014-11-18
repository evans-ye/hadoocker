#!/bin/bash

TAG=hadoocker/hadoop-client:centos62

docker rmi $TAG
docker build  --force-rm --no-cache -t $TAG .
