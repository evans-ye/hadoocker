#!/bin/bash

## update hadoop ecosystem configuration
HOSTNAME=`hostname -f`
sed -i "s/hdfs:\/\/localhost:8020/hdfs:\/\/$HOSTNAME:8020/" /etc/hadoop/conf/core-site.xml
sed -i "s/localhost/$HOSTNAME/g" /etc/hadoop/conf/yarn-site.xml
sed -i "s/localhost/$HOSTNAME/g" /etc/hadoop/conf/mapred-site.xml
sed -i "s/mapred.job.tracker/mapreduce.jobtracker.address/" /etc/hadoop/conf/mapred-site.xml
sed -i "s/hdfs:\/\/localhost:8020/hdfs:\/\/$HOSTNAME:8020/" /etc/hbase/conf/hbase-site.xml
sed -i "s/server.1=localhost:2888:3888/server.1=$HOSTNAME:2888:3888/" /etc/zookeeper/conf/zoo.cfg
## HADOOP-9487 Deprecation warnings in Configuration should go to their own log or otherwise be suppressible
sed -i.bak "s/# log4j.logger.org.apache.hadoop.conf.Configuration.deprecation=WARN/log4j.logger.org.apache.hadoop.conf.Configuration.deprecation=WARN/" /etc/hadoop/conf/log4j.properties
## start HDFS
for i in hadoop-hdfs-namenode hadoop-hdfs-datanode ; do (sudo service $i start ;) & done
## start ZooKeeper
sudo su -s /bin/bash zookeeper -c "zookeeper-server start"
## start YARN and HBase
for i in hadoop-yarn-resourcemanager hadoop-yarn-nodemanager hadoop-mapreduce-historyserver hbase-master hbase-regionserver ; do sudo service $i start ; done

/usr/sbin/sshd -D
