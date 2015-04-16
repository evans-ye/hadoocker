#!/bin/bash

vagrant up --no-parallel

# Wait untill containers are ready
while true; do
    vagrant ssh hadoop -c "hadoop fs -ls /"
    if [ $? -eq 0 ]; then break; fi
    sleep 1
done
echo "HDFS online"

echo "Getting in the service container..."
vagrant ssh service

