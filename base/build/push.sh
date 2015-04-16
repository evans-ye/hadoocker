#!/bin/bash

TAG=evansye/base:centos6

docker rmi $TAG
docker tag $TAG-dev $TAG
docker push $TAG
