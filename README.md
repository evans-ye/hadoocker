# Hadoocker

The project goal is to speed up software development process and enhance existing testing framework by utilizing docker container technology.

The container can be created and destroyed promptly! ( < 10 secs)

Some key featrues provided:

* hadoocker-base CentOS docker container

* bigtop-hadoop pseudo-distributed docker container

* hadoop and service integration testing and CI template

## Docker images

* hadoocker-base CentOS (hadoocker/hadoocker-base)

* Bigtop Hadoop pseudo-distributed (hadoocker/hadoop)

* Bigtop Hadoop client (hadoocker/hadoop-client)


* hadoocker-base CentOS (hadoocker/virtualbox-vm/hadoocker-base)

* Bigtop Hadoop pseudo-distributed (hadoocker/virtualbox-vm/hadoop)

* Bigtop Hadoop client (hadoocker/virtualbox-vm/hadoop-client)

## Prerequisites

### OS X

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

* Install [Vagrant](http://www.vagrantup.com/downloads.html)

### Windows

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

* Install [Vagrant](http://www.vagrantup.com/downloads.html)

* Install [git](http://git-scm.com/download/win)(to get git bash. you can install cygwin instead)

### Linux

* [Kernel Requirements](http://docker.readthedocs.org/en/v0.5.3/installation/kernel/)

* Install [Vagrant](http://www.vagrantup.com/downloads.html)

* Install [Docker](https://docs.docker.com/installation/)

### Version

The hadoocker toolkit has been tested in the following environment, thus please make sure you have at least equal or higher software verison:

* OS: yungsang/boot2docker 1.3.5, CentOS

* VirtualBox: 4.3.15

* Vagrant 1.7.1

* Docker: 1.3.2

## OS X Getting Started

```
vagrant box add yungsang/boot2docker --insecure
git clone https://github.com/evans-ye/hadoocker.git
cd hadoocker/hadoocker-base
vagrant up
vagrant ssh
```

## Windows Getting Started

open git bash or cygwin

```
git clone https://github.com/evans-ye/hadoocker.git
cd hadoocker/virtualbox-vm/centos-docker-platform/
vagrant up
vagrant ssh
```

## Linux Getting Started

```
git clone https://github.com/evans-ye/hadoocker.git
cd hadoocker/hadoocker-base
vagrant up
vagrant ssh
```

* Note: when first time doing vagrant up, it might take 3-5min to download the image

### Running Hadoocker on existing Linux or boot2docker in PRIVATE NETWORK (You have private dockerhub)

If you already have Linux environment which does not created from hadoocker, please

be aware that the newest Docker with security fix does not allow non https dockerhub access.

In order to access private dockerhub, you needs to add a configuration in docker daemon to workaround it.

* On CentOS:

```
sudo echo "other_args=\"--insecure-registry <PRIVATE_DOCKERHUB_FQDN>\"" > /etc/sysconfig/docker
sudo /etc/init.d/docker restart
```

See hadoocker/virtualbox-vm/centos-docker-platform/provision.sh

And, make sure you have SELINUX DISABLED!!!

```
$ vim /etc/sysconfig/selinux
SELINUX=disabled
```
Otherwise, you will get Broken pipe failure while doing vagrant ssh.

* On boot2docker:
 * Aside the security fix workaround, there is also a critical issue which is that the file system view can be different under certain image building operations. To avoid that happening, the boot2docker driver should be specified to devicemapper.

```
sudo sh -c "echo \"EXTRA_ARGS=\\\"--insecure-registry <PRIVATE_DOCKERHUB_FQDN> --storage-driver=devicemapper\\\"\" > /var/lib/boot2docker/profile"
sudo /etc/init.d/docker restart
```

See hadoocker/docker-platform/provision.sh

## Usage

### Create a CentOS docker container

```
cd hadoocker-base 
vagrant up
vagrant ssh
```

### Create a bigtop-hadoop docker container

```
cd hadoop 
vagrant up
vagrant ssh
```

* Note: The hadoop container may require memory up to 2500MB to be running smoothly

### Create hadoop and hadoop client containers for doing hadoop integration test

```
cd hadoop-cluster
./execute.sh
```

### Create Hadoop and Hadoop client VMs

cd virtualbox-vm/hadoop-cluster
./execute.sh

## Use Case

* I want a VM

* I want to test my newly developed pig script

* I want to test my hbase feature

* Develop continuous integration to run end to end integration test with hadoop

## Docker Registry web UI

* Browse available images on [registry-ui](http://<PRIVATE_DOCKERHUB_FQDN>:8080/ui/repository/index). For unknown reason, this takes times loading, please just wait:)

* Search private dockerhub(registry) in command-line:

```
[root@evans ~]# $ docker search <PRIVATE_DOCKERHUB_FQDN>/hadoocker
NAME                  DESCRIPTION   STARS     OFFICIAL   AUTOMATED
library/hadoocker                        0
library/hadoocker-client                 0
```

## Materials

* [Fits docker into devops](http://www.slideshare.net/saintya/fits-docker-into-devops)

* [Docker workshop](http://www.slideshare.net/saintya/docker-workshop-40590740)

