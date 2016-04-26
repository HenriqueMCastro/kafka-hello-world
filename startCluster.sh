#!/bin/bash



# zookeeper nodes
zookeeperServers="zookeeper-node-1,zookeeper-node-2,zookeeper-node-3"
for id in `seq 1 3`;
do
	docker run -d --net=mynetwork -h zookeeper-node-${id} -e ZOO_LOG_DIR=/var/log/zookeeper -e MYID=${id} -e SERVERS=${zookeeperServers} --name=zookeeper-node-${id} --net=mynetwork mesoscloud/zookeeper:3.4.6-ubuntu-14.04
done

ZK_HOSTS="zookeeper-node-1:2181,zookeeper-node-2:2181,zookeeper-node-3:2181"

docker build -t kafka-node kafka-node
for id in `seq 1 5`;
do
	docker run --privileged -d -t --net=mynetwork -h kafka-node-${id} --name kafka-node-${id} -e ZK_HOSTS=${ZK_HOSTS} -e BROKER_ID=${id} -e HOST_NAME=kafka-node-${id} kafka-node
done

docker build -t kafka-manager kafka-manager
docker run --privileged -d -t --net=mynetwork --name kafka-manager -p 9000:9000 -e ZK_HOSTS=${ZK_HOSTS} kafka-manager


BOOTSTRAP_SERVERS="kafka-node-1:9092,kafka-node-2:9092,kafka-node-3:9092,kafka-node-4:9092,kafka-node-5:9092"
docker build -t kafka-client kafka-client
docker run -d -t --net=mynetwork --name kafka-client -v /logs:/logs -e BOOTSTRAP_SERVERS=${BOOTSTRAP_SERVERS} kafka-client

docker build -t logkafka logkafka
docker run --privileged -d -t --net=mynetwork -h logkafka --name logkafka -v /logs:/logs -e ZK_HOSTS=${ZK_HOSTS} logkafka

#docker run --privileged -d -t --net=mynetwork -h graylog  --name graylog -p 8080:9000 -p 12201:12201 graylog2/allinone

LOGSTASH="logstash-kafka"
docker build -t ${LOGSTASH} ${LOGSTASH}
docker run --privileged -d -t --net=mynetwork -h ${LOGSTASH} --name ${LOGSTASH} -e LOGSTASH_CONF=/opt/logstash/config/logstash.conf -v /logs:/logs ${LOGSTASH}

#SPARK="kafka-spark-streaming"
#docker build -t ${SPARK} ${SPARK}
#docker run --privileged -d -t --net=mynetwork -h ${SPARK} --name ${SPARK} ${SPARK}

docker run -d -t --net=mynetwork -p 9200:9200 -p 9300:9300 -h elasticsearch --name elasticsearch elasticsearch
docker build -t henriquemcastro/kafka-connect-elasticsearch kafka-connect-elasticsearch
docker run -d -t --net=mynetwork -h kafka-connect-elasticsearch --add-host=database.dev.adhslx.int:10.1.230.1 -e ES_CLUSTER_NAME=dev -e BOOTSTRAP_SERVERS=kafka-node-1:9092,kafka-node-2:9092,kafka-node-3:9092,kafka-node-4:9092,kafka-node-5:9092 -e ES_HOSTNAME=database.dev.adhslx.int -e KAFKA_TOPICS=connect-click --name kafka-connect-elasticsearch henriquemcastro/kafka-connect-elasticsearch

mv logs/* /logs
