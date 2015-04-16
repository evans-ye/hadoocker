FROM evansye/base:centos6
MAINTAINER Evans Ye <evansye@apache.org>

ADD hadoop-client.sh /hadoop-client.sh
ADD hadoop-env.sh /hadoop-env.sh
RUN /hadoop-client.sh

CMD /usr/sbin/sshd -D
