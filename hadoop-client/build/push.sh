#!/bin/bash

TAG=evansye/bigtop-client:centos6

docker rmi $TAG
docker tag $TAG-dev $TAG
docker push $TAG
