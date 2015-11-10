FROM alpine
MAINTAINER Mark McKenna <m4rkmckenna@gmail.com>
LABEL version="0.8.0-incubating"

ENV brooklyn_version 0.8.0-incubating
RUN apk upgrade --update ; \
	apk add openjdk7-jre bash openssl ; \
	rm -rf /var/lib/apt/lists/*
RUN wget http://mirrors.muzzy.org.uk/apache/incubator/brooklyn/apache-brooklyn-${brooklyn_version}/apache-brooklyn-${brooklyn_version}-bin.tar.gz -qO /apache-brooklyn.tar.gz ; \
    tar zxf apache-brooklyn.tar.gz ; \
    rm -f apache-brooklyn.tar.gz ; \
	mv /apache-brooklyn-${brooklyn_version}-bin /apache-brooklyn
WORKDIR /apache-brooklyn

VOLUME [ "/root/.brooklyn", "/root/.ssh" ]

EXPOSE 8081

ENTRYPOINT [ "./bin/brooklyn", "launch" ]