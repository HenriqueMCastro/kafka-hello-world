FROM logstash

WORKDIR /opt/logstash/bin

RUN logstash-plugin install logstash-codec-gzip_lines

RUN mkdir /opt/logstash/config

COPY logstash.conf /opt/logstash/config

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
