#!/bin/bash

TAG=hadoocker/hadoop:centos62

docker rmi $TAG
docker build  --force-rm --no-cache -t $TAG .
