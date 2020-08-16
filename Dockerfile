FROM ubuntu:18.04 
ENV KAFKA_USER=ocfkafka \
KAFKA_DATA_DIR=/var/lib/kafka \
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
KAFKA_HOME=/opt/kafka \
PATH=$PATH:/opt/kafka/bin

ARG KAFKA_VERSION=2.6.0
ARG KAFKA_DIST=kafka_2.12-${KAFKA_VERSION}

RUN sed -i 's/archive.ubuntu.com/mirrors.ocf.berkeley.edu/g' /etc/apt/sources.list
RUN sed -i 's/security.ubuntu.com/mirrors.ocf.berkeley.edu/g' /etc/apt/sources.list

RUN set -x \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless wget gpg net-tools iputils-ping netcat-openbsd

RUN wget -q "https://www.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA_DIST.tgz" \
    && wget -q "https://www.apache.org/dist/kafka/$KAFKA_VERSION/$KAFKA_DIST.tgz.asc" \
    && wget -q "https://kafka.apache.org/KEYS" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --import KEYS \
    && gpg --batch --verify "$KAFKA_DIST.tgz.asc" "$KAFKA_DIST.tgz" \
    && tar -xzf "$KAFKA_DIST.tgz" -C /opt \
    && rm -r "$GNUPGHOME" "$KAFKA_DIST.tgz" "$KAFKA_DIST.tgz.asc"
    
COPY log4j.properties /opt/$KAFKA_DIST/config/

RUN set -x \
    && ln -s /opt/$KAFKA_DIST $KAFKA_HOME \
    && useradd $KAFKA_USER \
    && usermod -u 503 $KAFKA_USER \
    && usermod -g 3 $KAFKA_USER \
    && [ `id -u $KAFKA_USER` -eq 503 ] \
    && [ `id -g $KAFKA_USER` -eq 3 ] \
    && mkdir -p $KAFKA_DATA_DIR \
    && chown -R "$KAFKA_USER:$KAFKA_USER"  /opt/$KAFKA_DIST \
    && chown -R "$KAFKA_USER:$KAFKA_USER"  $KAFKA_DATA_DIR
