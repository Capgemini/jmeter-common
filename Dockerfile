FROM alpine:3.1

# Install OpenJDK 7
RUN apk add --update openjdk7 ca-certificates bash && rm -rf /var/cache/apk/* && \
  find /usr/share/ca-certificates/mozilla/ -name "*.crt" -exec keytool -import -trustcacerts \
  -keystore /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/cacerts -storepass changeit -noprompt \
  -file {} -alias {} \; && \
  keytool -list -keystore /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/cacerts --storepass changeit

ENV JMETER_VERSION=2.13
ENV JAVA_HOME /usr/lib/jvm/java-1.7-openjdk
ENV JAVA=$JAVA_HOME/bin
ENV PATH=$PATH:$JAVA_HOME:$JAVA
ENV JMETER_BINARY=/opt/jmeter/apache-jmeter-$JMETER_VERSION/bin/jmeter

# Install JMeter
RUN mkdir -p /opt/jmeter && \
  cd /opt/jmeter && \
  wget http://www.mirrorservice.org/sites/ftp.apache.org/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
  tar xzf apache-jmeter-$JMETER_VERSION.tgz && \
  rm -f apache-jmeter-$JMETER_VERSION.tgz
