#!/bin/bash

TAG=evansye/bigtop:centos6

docker rmi $TAG
docker tag $TAG-dev $TAG
docker push $TAG
