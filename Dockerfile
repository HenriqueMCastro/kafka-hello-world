FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y zookeeperd

RUN apt-get install -y wget
RUN mkdir ~/Downloads && \
	wget "http://mirror.cc.columbia.edu/pub/software/apache/kafka/0.9.0.1/kafka_2.11-0.9.0.1.tgz" -O ~/Downloads/kafka.tgz && \
	mkdir -p ~/kafka && \
	cd ~/kafka && \
	tar -xvzf ~/Downloads/kafka.tgz --strip 1
RUN mkdir /var/log/kafka && touch /var/log/kafka/kafka.log
