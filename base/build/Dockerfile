FROM evansye/minimal:centos6
MAINTAINER Evans Ye <evansye@apache.org>

RUN ls /etc/yum.repos.d/CentOS-*.repo; \
 yum clean all; yum -y install openssh-server openssh-clients sudo wget tar zip vim cracklib-dicts telnet rpm-build redhat-lsb nscd java-1.7.0-openjdk-devel

ADD Bigtop.repo /etc/yum.repos.d/Bigtop.repo
ADD bash_profile /root/.bash_profile
ADD bashrc /root/.bashrc

RUN rpm -e cracklib-dicts --nodeps; \
# enable ssh
 sed -i.bak s/UsePAM\ yes/UsePAM\ no/ /etc/ssh/sshd_config; \
 ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key; \
 ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key; \

# requiretty off
 sed -i.bak 's/requiretty/!requiretty/' /etc/sudoers; \

# setup vagrant account
 mkdir /root/.ssh/; \
 chmod 0755 /root/.ssh; \
 wget http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub --no-check-certificate -O /root/.ssh/authorized_keys; \
 chmod 0644 /root/.ssh/authorized_keys; \

 touch /etc/sysconfig/network; \
 echo "NETWORKING=yes" > /etc/sysconfig/network; \

# cleanup
 yum -y clean all;

CMD /usr/sbin/sshd -D
