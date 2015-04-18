#!/bin/bash

TAG=evansye/hadoocker-hadoop:centos6

docker rmi $TAG-dev
docker build  --force-rm --no-cache -t $TAG-dev .
