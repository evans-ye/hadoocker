#!/bin/sh

centos6_minimal_iso="CentOS-6.6-x86_64-minimal.iso"
centos6_minimal_iso_url="http://mirrors.securehost.com/centos/6.6/isos/x86_64/CentOS-6.6-x86_64-minimal.iso"

ls |grep $centos6_minimal_iso

if [[ $? -ne 0 ]]; then
    echo "Download $centos6_minimal_iso"
    wget $centos6_minimal_iso_url -O $centos6_minimal_iso
fi

: ${BUILD_VERSION:="v$(date +'%Y%m%d')"}
export BUILD_VERSION

rm -i builds/*-${BUILD_VERSION}.box
packer build CentOS-6.6.json
shasum -a 256 builds/*-${BUILD_VERSION}.box
