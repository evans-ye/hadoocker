FROM hadoocker/base:centos62
MAINTAINER Evans Ye <innovansye@gmail.com>

ADD hadoop-client.sh /hadoop-client.sh
RUN /hadoop-client.sh

CMD /usr/sbin/sshd -D
