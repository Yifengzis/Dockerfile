FROM debian:buster
LABEL MAINTAINER="yifengzis@qq.com"
LABEL ansible_version="2.10.7"
LABEL ansible_home="/usr/share/ansible"

RUN sed -e '9,12 s|\#\ ||g' -e '8a export SHELL="bash"' -i /root/.bashrc && \
    sed -e 's|main|main\ contrib\ non-free|g' -e '$a deb http://deb.debian.org/debian buster-backports main contrib non-free' -i /etc/apt/sources.list && \
    apt update && apt install vim curl wget --no-install-recommends -y && \
    sed -e '78,80 s|^|\"\ |g' -i /usr/share/vim/vim81/defaults.vim && \
    apt install python3-pip --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m pip install --no-cache-dir pip -U && \
    pip install --no-cache-dir setuptools wheel paramiko && \
    pip install --no-cache-dir ansible-base==2.10.7 ansible==3.2.0

WORKDIR /usr/share/ansible

CMD [ "/bin/bash" ]