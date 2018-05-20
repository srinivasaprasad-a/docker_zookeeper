FROM ubuntu:16.04
MAINTAINER SrinivasaPrasadA

USER root

RUN apt-get update && \
    apt-get install -y openjdk-8-jdk openssh-server curl

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME

ENV ZK_VERSION 3.4.12

RUN curl -fSL http://www-us.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz -o /opt/zookeeper-$ZK_VERSION.tar.gz && \
    tar zxf /opt/zookeeper-$ZK_VERSION.tar.gz --directory /opt && \
    mv /opt/zookeeper-$ZK_VERSION /opt/zookeeper && \
    rm /opt/zookeeper-$ZK_VERSION.tar.gz

ENV ZK_HOME /opt/zookeeper

ADD zoo.cfg $ZK_HOME/conf/zoo.cfg

RUN mkdir /var/zookeeper && \
    chmod 777 /var/zookeeper

ADD start_up.sh /etc/start_up.sh

RUN chown root:root /etc/start_up.sh && \
    chmod 700 /etc/start_up.sh

CMD ["/etc/start_up.sh", "-d"]

EXPOSE 2181
