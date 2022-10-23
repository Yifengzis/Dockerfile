#!/bin/bash

image_name=registry.cn-hangzhou.aliyuncs.com/yifengzis/openresty
image_tag=1.21.4.1

docker build --no-cache -t ${image_name}:${image_tag} .

docker image ls ${image_name}:${image_tag}
