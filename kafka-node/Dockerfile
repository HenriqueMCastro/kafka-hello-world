FROM ubuntu:14.04

# install java 8
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN apt-get -y install oracle-java8-set-default

RUN apt-get install -y wget
RUN wget "http://mirror.cc.columbia.edu/pub/software/apache/kafka/0.9.0.1/kafka_2.11-0.9.0.1.tgz" -O kafka.tgz && \
	tar -xf kafka.tgz && \
	mv kafka_2.11-0.9.0.1 kafka

COPY mx4j-tools.jar /kafka/libs


COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 9092 9999 

CMD ["/kafka/bin/kafka-server-start.sh", "/kafka/config/server.properties"]
