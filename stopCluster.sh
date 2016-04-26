#!/bin/bash

docker rm -f --volumes zookeeper-node-1
docker rm -f --volumes zookeeper-node-2
docker rm -f --volumes zookeeper-node-3
docker rm -f --volumes kafka-node-1
docker rm -f --volumes kafka-node-2
docker rm -f --volumes kafka-node-3
docker rm -f --volumes kafka-node-4
docker rm -f --volumes kafka-node-5
docker rm -f --volumes kafka-manager
docker rm -f --volumes kafka-client
docker rm -f --volumes logkafka
docker rm -f --volumes graylog
docker rm -f --volumes logstash-kafka
docker rm -f --volumes kafka-spark-streaming
docker rm -f --volumes elasticsearch
docker rm -f --volumes kafka-connect-elasticsearch
mv /logs/01* logs/
