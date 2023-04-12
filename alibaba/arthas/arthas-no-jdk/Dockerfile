FROM alpine:3.17
LABEL MAINTAINER="yifengzis@qq.com"

ARG ARTHAS_VERSION=3.6.7

ENV MAVEN_HOST=https://maven.aliyun.com/repository/public

RUN wget -qO /tmp/arthas.zip "${MAVEN_HOST}/com/taobao/arthas/arthas-packaging/${ARTHAS_VERSION}/arthas-packaging-${ARTHAS_VERSION}-bin.zip" \
    && mkdir -p /opt/arthas \
    && unzip /tmp/arthas.zip -d /opt/arthas \
    && rm /tmp/arthas.zip

WORKDIR /opt/arthas
