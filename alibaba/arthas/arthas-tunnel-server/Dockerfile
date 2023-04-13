FROM debian:stable-slim
LABEL MAINTAINER="yifengzis@qq.com"

ARG ARTHAS_VERSION=3.6.7

RUN sed -e '9,12 s|\#\ ||g' -i /root/.bashrc \
    && echo "alias grep='grep --color'" >> /root/.bashrc \
    && echo ". /etc/profile.d/bash_completion.sh" >> /root/.bashrc \
    && debian_version=$(awk -F'=' '/^VERSION_CODENAME=/ {print $2}' /etc/os-release) \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ ${debian_version} main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ ${debian_version}-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian/ ${debian_version}-backports main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.tuna.tsinghua.edu.cn/debian-security ${debian_version}-security main contrib non-free" >> /etc/apt/sources.list \
    && apt update && apt upgrade -y \
    && apt install -y --no-install-recommends --no-install-suggests bash-completion procps fontconfig locales iputils-ping curl ca-certificates unzip dumb-init \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8 \
    && apt autoclean && rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME=/usr/java/jre8
ENV CLASSPATH=${JAVA_HOME}/lib

RUN curl -LfsSo openjdk.tar.gz https://mirrors.tuna.tsinghua.edu.cn/Adoptium/8/jre/x64/linux/OpenJDK8U-jre_x64_linux_hotspot_8u362b09.tar.gz \
    && mkdir -pv ${JAVA_HOME} && tar -zxf openjdk.tar.gz -C ${JAVA_HOME} --strip-components=1 && chown -R root:root /usr/java \
    && rm -rf openjdk.tar.gz && chown -R root:root /usr/java

RUN mkdir -pv /opt/arthas \
    && wget -qO /opt/arthas/arthas-tunnel-server.jar "https://maven.aliyun.com/repository/public/com/taobao/arthas/arthas-tunnel-server/${ARTHAS_VERSION}/arthas-tunnel-server-${ARTHAS_VERSION}-fatjar.jar"

WORKDIR /opt/arthas

ENTRYPOINT ["dumb-init", "--"]

CMD ["java", "-jar", "/opt/arthas/arthas-tunnel-server.jar"]
