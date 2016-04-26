#!/bin/sh

echo "bootstrap.servers is ${BOOTSTRAP_SERVERS}"
if [ -n "$BOOTSTRAP_SERVERS" ]; then
        sed -i 's/bootstrap.servers=localhost:9092/bootstrap.servers='"$BOOTSTRAP_SERVERS"'/g' /kafka/config/connect-standalone.properties
fi

sed -i 's/key.converter.schemas.enable=true/key.convert.schemas.enable=false/g' /kafka/config/connect-standalone.properties
sed -i 's/value.converter.schemas.enable=true/value.converter.schemas.enable=false/g' /kafka/config/connect-standalone.properties

exec "$@"
