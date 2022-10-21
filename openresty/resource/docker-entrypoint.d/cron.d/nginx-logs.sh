#!/bin/bash
# vim:sw=4:ts=4:et

set -e

nginxlogs_dir="/usr/local/openresty/nginx/logs"
#nginx_bin_dir="/usr/local/openresty/nginx/sbin"

cd $nginxlogs_dir
mmv \*.log \#1.log_$(date -d "1 day ago" +"%Y-%m-%d")

nginx -s reopen
