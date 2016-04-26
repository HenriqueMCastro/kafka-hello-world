#!/bin/sh

echo "LOGSTASH CONF is ${LOGSTASH_CONF}"
exec /opt/logstash/bin/logstash -f ${LOGSTASH_CONF} --debug
