#!/bin/bash

image_name=registry.cn-hangzhou.aliyuncs.com/yifengzis/arthas-tunnel-server
image_tag="3.6.7"

docker build --no-cache -t ${image_name}:${image_tag} .
