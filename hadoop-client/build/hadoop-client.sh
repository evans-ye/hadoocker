#!/bin/bash

## install hadoop related packages
sudo yum install -y hadoop-conf-pseudo hadoop-client hbase pig adhoc-query jdk
rm -f /etc/security/limits.d/hdfs.conf
rm -f /etc/security/limits.d/mapred.conf
rm -f /etc/security/limits.d/mapreduce.conf
rm -f /etc/security/limits.d/yarn.conf
rm -f /etc/security/limits.d/hbase.nofiles.conf
usermod -s /bin/bash hbase
yes | mv /hadoop-env.sh /etc/hadoop/conf/hadoop-env.sh

## Create hbase.local.dir to save coprocessor jars
HBASE_LOCAL_DIR=/var/hadoop/hbase
mkdir -p $HBASE_LOCAL_DIR
chown -R hbase:hbase $HBASE_LOCAL_DIR

## configure yar-site.xml
sed --in-place '/<\/configuration>/ i\
  <property> \
      <name>yarn.resourcemanager.address</name> \
      <value>localhost:8032</value> \
  </property>' /etc/hadoop/conf/yarn-site.xml

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
      <value>$HBASE_LOCAL_DIR</value>
  </property>
  <property>
      <name>hbase.cluster.distributed</name>
      <value>true</value>
  </property>
  <property>
    <name>hbase.zookeeper.quorum</name>
    <value>bigtop-hadoop.hadoocker</value>
  </property>
</configuration>
EOF
"
echo "server.1=bigtop-hadoop.hadoocker:2888:3888" >> /etc/zookeeper/conf/zoo.cfg


## update hadoop configuration
HOSTNAME="bigtop-hadoop.hadoocker"
sed -i "s/hdfs:\/\/localhost:8020/hdfs:\/\/$HOSTNAME:8020/" /etc/hadoop/conf/core-site.xml
sed -i "s/localhost/$HOSTNAME/g" /etc/hadoop/conf/yarn-site.xml
sed -i "s/localhost/$HOSTNAME/g" /etc/hadoop/conf/mapred-site.xml
sed -i "s/mapred.job.tracker/mapreduce.jobtracker.address/" /etc/hadoop/conf/mapred-site.xml
sed -i "s/hdfs:\/\/localhost:8020/hdfs:\/\/$HOSTNAME:8020/" /etc/hbase/conf/hbase-site.xml
sed -i "s/server.1=localhost:2888:3888/server.1=$HOSTNAME:2888:3888/" /etc/zookeeper/conf/zoo.cfg
## HAD9487 Deprecation warnings in Configuration should go to their own log or otherwise be suppressible
sed -i "s/# log4j.logger.org.apache.hadoop.conf.Configuration.deprecation=WARN/log4j.logger.org.apache.hadoop.conf.Configuration.deprecation=WARN/" /etc/hadoop/conf/log4j.properties
