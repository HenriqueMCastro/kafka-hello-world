#!/bin/sh

click="{\"uuid\": \"562a832858744e8282a68362664f88de\",\"log\": 4,\"date\": 1459510862572,\"v\": \"0.0.3\",\"user\": {\"ui_o\": 1,\"gender\": 0},\"ua\": {\"br\": {},\"os\": {}},\"inv\": {\"url\": \"http://a.adhslx.com/?id=359\",\"dom\": \"a.adhslx.com\"},\"resp\": {},\"sys\": {\"ip\": \"41.137.133.50\",\"dc\": 1,\"s\": 5},\"geo\": {},\"failover\": {}}"

while : 
do
	echo ${click} >> /logs/01-TAG-CLICK.json
	sleep 10
done
