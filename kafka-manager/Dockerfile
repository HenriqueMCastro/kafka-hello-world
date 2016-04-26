FROM ubuntu:14.04

# install git
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt-get update
RUN apt-get install -y git

# install java 8
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get -y install oracle-java8-installer
RUN apt-get -y install oracle-java8-set-default


RUN mkdir ~/Downloads && \
	cd ~/Downloads && \
	git clone https://github.com/yahoo/kafka-manager.git 

RUN cd ~/Downloads/kafka-manager && \
	echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt 
RUN cd ~/Downloads/kafka-manager && \
	./sbt clean dist
RUN apt-get -y install unzip
RUN unzip  -d / ~/Downloads/kafka-manager/target/universal/kafka-manager-1.3.0.7.zip 

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/kafka-manager-1.3.0.7/bin/kafka-manager", "-Dconfig.file=/kafka-manager-1.3.0.7/conf/application.conf"]




