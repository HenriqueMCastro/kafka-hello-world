#!/bin/sh

syslogMessage="{ \"version\": \"1.1\", \"host\": \"example.org\", \"short_message\": \"A short message that helps you identify what is going on\", \"full_message\": \"Backtrace here nmore stuff\", \"timestamp\":1385053862.3072,\"level\": 1,\"_user_id\": 9001,\"_some_info\": \"foo\",\"_some_env_var\": \"bar\"}"

for i in `seq 1 1000`;
do
	echo $syslogMessage >> /logs/gelf-20160413
done
