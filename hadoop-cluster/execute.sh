#!/bin/bash

vagrant up --no-parallel

# Wait untill containers are ready
while true; do
    echo "hadoop fs -ls /" | vagrant ssh hadoop
    if [ $? -eq 0 ]; then break; fi
    sleep 1
done
echo "HDFS online"

echo "Getting in the service container..."
vagrant ssh service

