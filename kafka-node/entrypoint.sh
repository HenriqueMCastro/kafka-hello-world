#!/bin/sh

if [ -n "$ZK_HOSTS" ]; then
	sed -i '/zookeeper.connect=localhost:2181/c\' /kafka/config/server.properties 
	echo "zookeeper.connect=${ZK_HOSTS}" >> /kafka/config/server.properties
fi

if [ -n "$BROKER_ID" ]; then
        sed -i '/broker.id=0/c\' /kafka/config/server.properties 
        echo "broker.id=${BROKER_ID}" >> /kafka/config/server.properties
fi

if [ -n "$HOST_NAME" ]; then
        sed -i '/host.name =/c\' /kafka/config/server.properties 
        echo "host.name=${HOST_NAME}" >> /kafka/config/server.properties
fi

export JMX_PORT=9999

exec "$@" 
