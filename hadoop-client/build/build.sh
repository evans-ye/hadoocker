#!/bin/bash

TAG=evansye/bigtop-client:centos6

yes | cp ../../hadoop/build/hadoop-env.sh .

docker rmi $TAG-dev
docker build  --force-rm --no-cache -t $TAG-dev .
