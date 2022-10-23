#!/bin/bash
# vim:sw=4:ts=4:et

set -e
#set -x

if [[ -z ${nginx_logs_dir} ]]; then
    nginx_logs_dir="/usr/local/openresty/nginx/logs"
fi
if [[ -z ${nginx_logs_retention_time} ]]; then
    nginx_logs_retention_time=31
fi
#nginx_bin_dir="/usr/local/openresty/nginx/sbin"

log_cut() { 
    cd $nginx_logs_dir
    mmv \*.log \#1_$(date -d "1 day ago" +"%Y-%m-%d").log
    nginx -s reopen
}

log_clean() {
    sum=$(find ${nginx_logs_dir} -type f -mtime +${nginx_logs_retention_time} | grep -E "[0-9]{4}(\-[0-9]{2}){2}" | wc -l)
    if [[ ${sum} -ne 0 ]]; then
        find ${nginx_logs_dir} -type f -mtime +${nginx_logs_retention_time} | grep -E "[0-9]{4}(\-[0-9]{2}){2}" | xargs rm
    fi
}

main() {
    log_cut
    log_clean
}

main
