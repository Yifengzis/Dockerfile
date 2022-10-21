#!/bin/bash
# vim:sw=4:ts=4:et

set -e

/usr/sbin/cron
crontab /docker-entrypoint.d/cron.d/crontab 

exit 0
