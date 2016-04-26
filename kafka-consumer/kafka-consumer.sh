#!/bin/sh

topicName=$1

docker exec -t kafka-client ./kafka-simple-consumer-shell.sh --topic ${topicName} --broker-list kafka-node-1:9092,kafka-node-2:9092,kafka-node-3:9092,kafka-node-4:9092,kafka-node-5:9092  --partition 0
