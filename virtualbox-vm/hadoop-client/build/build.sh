#!/bin/bash

echo "Copy Hadoop client installation and init scritps"
rm -f hadoop-env.sh vagrant.sh cleanup.sh
/bin/cp ../../../hadoop-client/build/hadoop-client.sh .
/bin/cp ../../../hadoop/build/hadoop-env.sh .
/bin/cp ../../vagrant-boxes/packer/scripts/vagrant.sh .
/bin/cp ../../vagrant-boxes/packer/scripts/cleanup.sh .

echo "Destroy VM before build started"
vagrant destroy -f

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

vagrant up
rm -rvf package.box hadoocker-bigtop-client-x86_64-${BUILD_VERSION}.box
vagrant package
mv -v package.box hadoocker-bigtop-client-x86_64-${BUILD_VERSION}.box
