FROM evansye/base:centos6
MAINTAINER Evans Ye <evansye@apache.org>

ADD jdk.sh /etc/profile.d/jdk.sh
ADD provision.sh /provision.sh
ADD hadoop-init.sh /hadoop-init.sh
ADD hadoop-env.sh /hadoop-env.sh
RUN yum -y install sudo
RUN /provision.sh

CMD /hadoop-init.sh
