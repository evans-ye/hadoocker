# Hadoocker

This project's goal is to speed up software development process and enhance Hadoop dev and test framework by utilizing Docker technology.

Some key featrues provided:

* template to create centos docker container

* template to create hadoop psedo cluster docker container

## Prerequisites

### OS X and Windows

* Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

* Install [Vagrant](http://www.vagrantup.com/downloads.html)

* Get the boot2docker VM

```
vagrant box add yungsang/boot2docker --insecure
```

### Linux

* [Kernel Requirements](http://docker.readthedocs.org/en/v0.5.3/installation/kernel/)

* Install [Vagrant](http://www.vagrantup.com/downloads.html)


## Getting Started

```
cd hadoocker/base
./build.sh
vagrant up
vagrant ssh
```

## Usage

### Create a centos docker container

```
cd base 
vagrant up
vagrant ssh
```

### Create a hadoop docker container

```
cd hadoop 
vagrant up
vagrant ssh
```

## Use Case

* I want a VM

* I want to test my newly developed pig script

* I want to test my hbase feature

* Develop continuous integration and1 run end to end integration test with hadoop

## Docker Materials

* [Fits docker into devops](http://www.slideshare.net/saintya/fits-docker-into-devops)

* [Docker workshop](http://www.slideshare.net/saintya/docker-workshop-40590740)
