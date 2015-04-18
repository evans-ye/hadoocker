#!/bin/bash

TAG=evansye/hadoocker-base:centos6

docker rmi $TAG
docker tag $TAG-dev $TAG
docker push $TAG
