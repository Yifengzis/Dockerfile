#!/bin/bash

image_name=registry.cn-hangzhou.aliyuncs.com/yifengzis/arthas
image_tag="3.6.7"

if [ $(whoami) == root ];then
    docker build --no-cache -t ${image_name}:${image_tag}-no-jdk .
else
    sudo docker build --no-cache -t ${image_name}:${image_tag}-no-jdk .
fi
