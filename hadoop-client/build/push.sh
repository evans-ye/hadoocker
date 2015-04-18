#!/bin/bash

TAG=evansye/hadoocker-hadoop-client:centos6

docker rmi $TAG
docker tag $TAG-dev $TAG
docker push $TAG
