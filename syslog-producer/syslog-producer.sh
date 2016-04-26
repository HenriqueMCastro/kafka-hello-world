#!/bin/sh

syslogMessage="May 11 10:40:48 scrooge disk-health-nurse[26783]: [ID 702911 user.error] m:SY-mon-full-500 c:H : partition health measures for /var did not suffice - still using 96% of partition space"

for i in `seq 1 1000`;
do
	echo $syslogMessage >> /logs/syslog-20160413
done
