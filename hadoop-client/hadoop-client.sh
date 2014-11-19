#!/bin/bash

## install hadoop related packages
sudo yum install -y hadoop-conf-pseudo hadoop-client hbase pig java-1.7.0-openjdk-devel.x86_64
rm -f /etc/security/limits.d/hdfs.conf
rm -f /etc/security/limits.d/mapred.conf
rm -f /etc/security/limits.d/mapreduce.conf
rm -f /etc/security/limits.d/yarn.conf
rm -f /etc/security/limits.d/hbase.conf
usermod -s /bin/bash hbase

## enable HBase with ZooKeeper
sudo su -s /bin/bash root -c "cat > /etc/hbase/conf/hbase-site.xml << EOF
<?xml version=\"1.0\"?>
<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
<configuration>
  <property>
      <name>hbase.rootdir</name>
      <value>hdfs://localhost:8020/hbase</value>
  </property>
  <property>
      <name>hbase.tmp.dir</name>
      <value>/var/hbase</value>
  </property>
  <property>
      <name>hbase.cluster.distributed</name>
      <value>true</value>
  </property>
  <property>
    <name>hbase.zookeeper.quorum</name>
    <value>hadoop.hadoocker</value>
  </property>
</configuration>
EOF
"
echo "server.1=hadoop.hadoocker:2888:3888" >> /etc/zookeeper/conf/zoo.cfg

## update hadoop configuration
sed -i.bak "s/hdfs:\/\/localhost:8020/hdfs:\/\/hadoop.hadoocker:8020/" /etc/hadoop/conf/core-site.xml
sed -i.bak "s/localhost:8021/hadoop.hadoocker:8021/" /etc/hadoop/conf/mapred-site.xml
sed -i.bak "s/hdfs:\/\/localhost:8020/hdfs:\/\/hadoop.hadoocker:8020/" /etc/hbase/conf/hbase-site.xml
