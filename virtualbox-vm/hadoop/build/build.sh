#!/bin/bash

echo "Copy Hadoop installation and init scritps"
rm -f provision.sh* hadoop-env.sh hadoop-init.sh* jdk.sh vagrant.sh cleanup.sh
/bin/cp ../../../hadoop/build/provision.sh .
/bin/cp ../../../hadoop/build/hadoop-env.sh .
/bin/cp ../../../hadoop/build/hadoop-init.sh .
/bin/cp ../../../hadoop/build/jdk.sh .
/bin/cp ../../vagrant-boxes/packer/scripts/vagrant.sh .
/bin/cp ../../vagrant-boxes/packer/scripts/cleanup.sh .

echo "Disable sshd foreground"
sed -i.bak 's@/usr/sbin/sshd -D@#/usr/sbin/sshd -D@g' hadoop-init.sh
sed -i.bak 's@/etc/hosts@/etc/hosts.bak@g' provision.sh

echo "Destroy VM before build started"
vagrant destroy -f

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

vagrant up
rm -rvf package.box hadoocker-bigtop-x86_64-${BUILD_VERSION}.box
vagrant package
mv -v package.box hadoocker-bigtop-x86_64-${BUILD_VERSION}.box
