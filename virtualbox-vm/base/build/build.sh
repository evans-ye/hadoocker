#!/bin/bash

echo "Copy installation scritps"
/bin/cp ../../../hadoop-client/build/hadoop-client.sh .
/bin/cp ../../../base/build/Bigtop.repo .
/bin/cp ../../vagrant-boxes/packer/scripts/cleanup.sh .


echo "Destroy VM before build started"
vagrant destroy -f

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

vagrant up
rm -rvf package.box hadoocker-base-x86_64-${BUILD_VERSION}.box
vagrant package
mv -v package.box hadoocker-base-x86_64-${BUILD_VERSION}.box
