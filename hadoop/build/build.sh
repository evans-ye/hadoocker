#!/bin/bash

TAG=evansye/bigtop:centos6

docker rmi $TAG-dev
docker build  --force-rm --no-cache -t $TAG-dev .
