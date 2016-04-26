#!/bin/sh

CONNECT_PROCESS_FILE=connect-standalone.properties
CONNECT_ES_SINK=connect-elasticsearch-sink.properties

CLASSPATH=target/*-jar-with-dependencies.jar
java -cp $CLASSPATH org.apache.kafka.connect.cli.ConnectStandalone $CONNECT_PROCESS_FILE $CONNECT_ES_SINK
