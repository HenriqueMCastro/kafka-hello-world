#!/bin/sh

if [ -n "$ZK_HOSTS" ]; then
	sed -i 's/zookeeper.connect = "127.0.0.1:2181"/zookeeper.connect = "'"$ZK_HOSTS"'"/g' /opt/logkafka/conf/logkafka.conf
fi

exec "$@" 
