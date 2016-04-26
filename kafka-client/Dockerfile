FROM java:8

RUN apt-get update
RUN apt-get install -y wget nano
RUN wget "http://mirror.cc.columbia.edu/pub/software/apache/kafka/0.9.0.1/kafka_2.11-0.9.0.1.tgz" -O kafka.tgz && \
	tar -xf kafka.tgz && \
	mv kafka_2.11-0.9.0.1 kafka
COPY hit-connector.properties /kafka/config
COPY click-connector.properties /kafka/config
COPY client-connector.properties /kafka/config
COPY search-connector.properties /kafka/config
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR kafka

EXPOSE 8083

CMD ["bin/connect-standalone.sh","config/connect-standalone.properties","config/hit-connector.properties","config/click-connector.properties","config/client-connector.properties","config/search-connector.properties"]
