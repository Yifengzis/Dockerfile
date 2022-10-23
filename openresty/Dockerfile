FROM debian:stable-slim
LABEL MAINTAINER="yifengzis@qq.com"

RUN sed -e '9,12 s|\#\ ||g' -i /root/.bashrc \
    && echo "alias grep='grep --color'" >> /root/.bashrc \
    && echo ". /etc/profile.d/bash_completion.sh" >> /root/.bashrc \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && debian_version=$(awk -F'=' '/^VERSION_CODENAME=/ {print $2}' /etc/os-release) \
    && echo "deb http://mirrors.aliyun.com/debian/ ${debian_version} main contrib non-free" > /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ ${debian_version}-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ ${debian_version}-proposed-updates main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ ${debian_version}-backports main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian/ ${debian_version}-backports-sloppy main contrib non-free" >> /etc/apt/sources.list \
    && echo "deb http://mirrors.aliyun.com/debian-security ${debian_version}-security main contrib non-free" >> /etc/apt/sources.list \
    && apt update && apt upgrade -y \
    && apt install -y --no-install-recommends --no-install-suggests bash-completion procps locales netcat-openbsd iputils-ping curl ca-certificates gnupg2 vim dumb-init cron \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8 \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://openresty.org/package/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/openresty.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/openresty.gpg] https://openresty.org/package/debian ${debian_version} openresty" > /etc/apt/sources.list.d/openresty.list \
    && apt update && apt install -y --no-install-recommends --no-install-suggests openresty \
    && ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log \
    && sed -e "s|#error_log  logs/error.log  notice;|error_log  logs/error.log  notice;|g" -e "s|worker_processes  1;|worker_processes  auto;|g" -e "s|#pid        logs/nginx.pid;|pid        /var/run/nginx.pid;|g" -i /usr/local/openresty/nginx/conf/nginx.conf \
    && rm -rf /var/lib/apt/lists/* /var/cache/debconf/* /var/log/* /var/tmp/* /tmp/* \
    && echo "set paste\nset mouse=\nsyntax on" >> /root/.vimrc

COPY resource/ /

ENV SHELL=/bin/bash LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/openresty/luajit/bin:/usr/local/openresty/nginx/sbin:/usr/local/openresty/bin

WORKDIR /usr/local/openresty/nginx

ENTRYPOINT ["dumb-init", "--", "/docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT

CMD ["/usr/bin/openresty", "-g", "daemon off;"]
