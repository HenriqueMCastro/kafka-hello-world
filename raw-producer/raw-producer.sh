#!/bin/sh

rawMessage="This is a raw message"

for i in `seq 1 1000`;
do
	echo $rawMessage >> /logs/raw-20160414
done
