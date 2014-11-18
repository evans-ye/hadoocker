FROM tianon/centos:6.2
MAINTAINER Evans Ye <innovansye@gmail.com>

ADD Bigtop.repo /etc/yum.repos.d/Bigtop.repo
ADD bash_profile /root/.bash_profile
ADD bashrc /root/.bashrc
ADD hadoop-client.sh /hadoop-client.sh

# enable ssh

RUN rpm -e cracklib-dicts --nodeps; \
 yum -y install openssh-server openssh-clients sudo wget tar rpm-build jdk zip vim cracklib-dicts; \
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

# setup default password
 echo "vagrant" | passwd --stdin root;

CMD /usr/sbin/sshd -D
