# Hadoocker Administration Guide

## Docker registry (private Dockerhub)

### Start registry

docker run -d --name hadoocker-registry -p 80:5000 -e GUNICORN_OPTS=["--preload"] -v /root/registry:/tmp/registry registry:latest

Details on [registry repository](https://registry.hub.docker.com/u/library/registry)

* 20150520: Add -e GUNICORN_OPTS=["--preload"] to fix the issue that registry can not start up ([issue 892](https://github.com/docker/docker-registry/issues/892))

### Start registry web ui

docker run -d --name hadoocker-registry-ui -p 8080:8080 -it -e APP_CONTEXT=ui -e REG1=http://<PRIVATE_DOCKERHUB_FQDN>/v1/ atcol/docker-registry-ui:latest

This can be browsed on http://<PRIVATE_DOCKERHUB_FQDN>:8080/ui

Details on [docker-registry-ui repository](https://registry.hub.docker.com/u/atcol/docker-registry-ui/)

### Services auto start

echo "docker start hadoocker-registry" >> /etc/rc.local
echo "docker start hadoocker-registry-ui" >> /etc/rc.local

### Backup & Restore
Since all the images can be built back via hudson job or dockerfiles, plus it's not fessiable to backup huge amount of images.
The backup strategy here for registry will be to rebuild all the base images and require all the services rerun there image building jobs.


To restore the registry service, just start the registry, docker will download necessary images and start  to function.

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
