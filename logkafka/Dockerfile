FROM  ubuntu:14.04

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:git-core/ppa -y
RUN add-apt-repository ppa:george-edison55/cmake-3.x -y
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y python-software-properties software-properties-common
RUN apt-get install -y git gcc g++ libpng-dev unzip python wget libtool automake cmake

# install librdkafka
RUN cd /tmp && \
	wget -N https://github.com/edenhill/librdkafka/archive/master.zip -O librdkafka.zip; unzip librdkafka.zip; rm -f librdkafka.zip && \
	cd librdkafka-master && \
	./configure && \
	make && \
	make install

# install libuv
RUN cd /tmp && \
	git clone https://github.com/libuv/libuv.git && \
	cd libuv && \
	sh autogen.sh && \
	./configure && \
	make && \
	make install

# install libpcre2
RUN cd /tmp && \
	wget -N http://sourceforge.net/projects/pcre/files/pcre2/10.20/pcre2-10.20.tar.gz; tar zxvf pcre2-10.20.tar.gz; rm -f pcre2-10.20.tar.gz && \
	cd pcre2-10.20 && \
	./configure && \
	make && \
	make install

# install logkafka
RUN git clone https://github.com/Qihoo360/logkafka.git

#RUN export LD_LIBRARY_PATH=/usr/local/lib
RUN cd logkafka && \
	cmake -H. -B_build -DCMAKE_INSTALL_PREFIX=_install -DINSTALL_LIBZOOKEEPER_MT=ON && \
	cd _build && \
	make -j4 && \
	make install

RUN mv /logkafka/_install /opt/logkafka && \
	rm -Rf /logkafka

WORKDIR /opt/logkafka

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/opt/logkafka/bin/logkafka","-f","/opt/logkafka/conf/logkafka.conf","-e","/opt/logkafka/conf/easylogging.conf"]
RUN ls /opt/logkafka
RUN ps aux 
