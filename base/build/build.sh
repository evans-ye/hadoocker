#!/bin/bash

TAG=evansye/hadoocker-base:centos6

yes |cp ../../hadoop-client/build/hadoop-client.sh .

docker rmi $TAG-dev
docker build  --force-rm --no-cache -t $TAG-dev .
