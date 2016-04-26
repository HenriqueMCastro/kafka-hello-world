#!/bin/sh

if [ -z "$ES_HOSTNAME" ]; then
  echo "Need to set ES_HOSTNAME"
  exit 1
fi

if [ -z "$ES_CLUSTER_NAME" ]; then
  echo "Need to set ES_CLUSTER_NAME"
  exit 1
fi

if [ -z "$KAFKA_TOPICS" ]; then
  echo "Need to set KAFKA_TOPICS"
  exit 1
fi

if [ -z "$BOOTSTRAP_SERVERS" ]; then
  echo "Need to set BOOTSTRAP_SERVERS"
  exit 1
fi

echo "ES_HOSTNAME=${ES_HOSTNAME}"
echo "KAFKA_TOPICS=${KAFKA_TOPICS}"
echo "BOOTSTRAP_SERVER=${BOOTSTRAP_SERVERS}"
echo "ES_CLUSTER_NAME=${ES_CLUSTER_NAME}"

mv connect-elasticsearch-sink.properties.template connect-elasticsearch-sink.properties
sed -i 's/es.host=/es.host='"$ES_HOSTNAME"'/g' connect-elasticsearch-sink.properties
sed -i 's/es.cluster.name=/es.cluster.name='"$ES_CLUSTER_NAME"'/g' connect-elasticsearch-sink.properties
sed -i 's/topics=/topics='"$KAFKA_TOPICS"'/g' connect-elasticsearch-sink.properties

mv connect-standalone.properties.template connect-standalone.properties
sed -i 's/bootstrap.servers=/bootstrap.servers='"$BOOTSTRAP_SERVERS"'/g' connect-standalone.properties

exec "$@"

