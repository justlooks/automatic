#!/bin/bash


: "${GF_DATADIR:=/var/lib/grafana}"
: "${GF_LOGDIR:=/var/log/grafana}"
: "${GF_PLUGINDIR:=/var/lib/grafana/plugins}"

GF_HOMEDIR="/usr/share/grafana"

/usr/sbin/grafana-server --homepath=${GF_HOMEDIR} --pidfile=/var/run/grafana-server.pid --config=/etc/grafana/grafana.ini cfg:default.log.mode='console' cfg:default.paths.data=${GF_DATADIR} cfg:default.paths.logs=${GF_LOGDIR} cfg:default.paths.plugins=${GF_PLUGINDIR} "$@"


# GF_DATADIR
# GF_LOGDIR
# GF_PLUGINDIR
