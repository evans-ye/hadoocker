FROM hadoocker/base:centos62
MAINTAINER Evans Ye <innovansye@gmail.com>

ADD jdk.sh /etc/profile.d/jdk.sh
ADD provision.sh /provision.sh
ADD hadoop-init.sh /hadoop-init.sh
RUN yum -y install sudo
RUN /provision.sh

CMD /hadoop-init.sh
