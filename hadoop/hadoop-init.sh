#!/bin/bash

## update hadoop ecosystem configuration
sed -i.bak "s/hdfs:\/\/localhost:8020/hdfs:\/\/`hostname -f`:8020/" /etc/hadoop/conf/core-site.xml
sed -i.bak "s/localhost:8021/`hostname -f`:8021/" /etc/hadoop/conf/mapred-site.xml
sed -i.bak "s/hdfs:\/\/localhost:8020/hdfs:\/\/`hostname -f`:8020/" /etc/hbase/conf/hbase-site.xml
sed -i.bak "s/server.1=localhost:2888:3888/server.1=`hostname -f`:2888:3888/" /etc/zookeeper/conf/zoo.cfg
## start HDFS
for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do (sudo service $i start ;) & done
## start ZooKeeper
sudo su -s /bin/bash zookeeper -c "zookeeper-server start"
## start MR1 and HBase
for i in mr1-jobtracker mr1-tasktracker hbase-master hbase-regionserver ; do (sudo service $i start ;) & done

/usr/sbin/sshd -D
