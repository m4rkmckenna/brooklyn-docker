FROM alpine
MAINTAINER Mark McKenna <m4rkmckenna@gmail.com>
LABEL version="0.9.0-SNAPSHOT"
ENV brooklyn_version 0.9.0-SNAPSHOT
ENV repository snapshots
RUN apk upgrade --update ; \
    apk add openjdk7-jre bash openssl curl; \
	  rm -rf /var/lib/apt/lists/*
RUN curl -s -L "https://repository.apache.org/service/local/artifact/maven/redirect?r=${repository}&g=org.apache.brooklyn&a=brooklyn-dist&v=${brooklyn_version}&p=tar.gz&c=dist" -o apache-brooklyn.tar.gz ; \
    tar zxf apache-brooklyn.tar.gz ; \
    rm -f apache-brooklyn.tar.gz ; \
	mv /brooklyn-dist-${brooklyn_version} /apache-brooklyn
WORKDIR /apache-brooklyn
VOLUME [ "/root/.brooklyn", "/root/.ssh" ]
EXPOSE 8081
ENTRYPOINT [ "./bin/brooklyn", "launch" ]
