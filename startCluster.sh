#!/bin/bash

docker build -t kafka_node .
docker run --privileged -d -t --name kafka_node -p 2181:2181 kafka_node
docker exec --user=root --privileged kafka_node /etc/init.d/zookeeper start
docker exec --user=root --privileged kafka_node sh -c 'nohup ~/kafka/bin/kafka-server-start.sh ~/kafka/config/server.properties > /var/log/kafka/kafka.log 2>&1 &'
