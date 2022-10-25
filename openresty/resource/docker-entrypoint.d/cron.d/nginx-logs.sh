#!/bin/bash
# vim:sw=4:ts=4:et

set -e
#set -x

echo -e "$(date +"%F %T") 开始执行 Nginx 日志切割与清理"
begintime=$(date +%s)

nginx_bin_dir="/usr/local/openresty/nginx/sbin"

if [[ -z ${nginx_logs_dir} ]]; then
    nginx_logs_dir="/usr/local/openresty/nginx/logs"
fi
if [[ -z ${nginx_logs_retention_time} ]]; then
    nginx_logs_retention_time=31
fi

log_cut() { 
    cd $nginx_logs_dir
    log_yesterday_date=$(date -d "yesterday" +"%Y-%m-%d")
    for i in $(ls *.log)
    do
        if [[ $(grep -E "[0-9]{4}(\-[0-9]{2}){2}" <<< ${i} | wc -l) -eq 0 ]]; then
            if [[ ! -d ${i%.log} ]]; then
                mkdir ${i%.log}
            fi
            if [[ ! -f "${i%.log}/${i%.log}_${log_yesterday_date}.log" ]]; then
                mv ${i} ${i%.log}/${i%.log}_${log_yesterday_date}.log
            else
                sum=$(ls ${i%.log}/${i%.log}_${log_yesterday_date}* | wc -l)
                mv ${i} ${i%.log}/${i%.log}_${log_yesterday_date}_${sum}.log
            fi
        fi
    done
    ${nginx_bin_dir}/nginx -s reopen
}

log_clean() {
    sum=$(find ${nginx_logs_dir} -mindepth 2 -maxdepth 2 -type f -mtime +${nginx_logs_retention_time} | grep -E "[0-9]{4}(\-[0-9]{2}){2}" | wc -l)
    if [[ ${sum} -ne 0 ]]; then
        find ${nginx_logs_dir} -mindepth 2 -maxdepth 2 -type f -mtime +${nginx_logs_retention_time} | grep -E "[0-9]{4}(\-[0-9]{2}){2}" | xargs rm
    fi
}

main() {
    log_cut
    log_clean
}

main

endtime=$(date +%s)
echo -e "$(date +"%F %T") 执行 Nginx 日志切割与清理完成, 耗时: $(($endtime - $begintime))s"
