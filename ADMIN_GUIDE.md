# Hadoocker Administration Guide

## Docker registry (private Dockerhub)

### Start registry

docker run -d --name hadoocker-registry -p 80:5000 -v /root/registry:/tmp/registry registry:latest

Details on [registry repository](https://registry.hub.docker.com/u/library/registry)

### Start registry web ui

docker run -d --name hadoocker-registry-ui -p 8080:8080 -it -e APP_CONTEXT=ui -e REG1=http://<PRIVATE_DOCKERHUB_FQDN>/v1/ atcol/docker-registry-ui:latest

This can be browsed on http://<PRIVATE_DOCKERHUB_FQDN>:8080/ui

Details on [docker-registry-ui repository](https://registry.hub.docker.com/u/atcol/docker-registry-ui/)

### Build Docker Containers

```
cd image-from-scratch && ./mkimage-yum.sh evansye/minimal
cd hadoocker-base && ./build.sh
cd hadoop && ./build.sh
cd hadoop-client && ./build.sh
```

### Build Vagrant boxes

* Note that, this can only be executed on physical machines such as Windows with cygwin installed.

```
cd virtualbox-vm/vagrant-boxes/packer && ./build.sh
cd virtualbox-vm/hadoocker-base/build && ./build.sh
cd virtualbox-vm/hadoop/build && ./build.sh
cd virtualbox-vm/hadoop-client/build && ./build.sh
```
