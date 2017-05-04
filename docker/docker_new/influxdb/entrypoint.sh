#!/bin/bash

CFGFILE="/etc/influxdb/influxdb.conf"
PIDFILE="/var/run/influxdb/influxd.pid"

if [ ! -d ${INFLUXDB_DATADIR} ];then
    mkdir -p ${INFLUXDB_DATADIR}
fi

mkdir -p /usr/local/share/collectd
mv /tmp/types.db /usr/local/share/collectd

sed -i "s#/var/lib#${INFLUXDB_DATADIR}#" ${CFGFILE}

exec /usr/bin/influxd -pidfile ${PIDFILE} -config ${CFGFILE} &
# test if influxdb already start
_RET=1
while [[ _RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of InfluxDB service startup ..."
    sleep 3
    curl -k http://localhost:8086/ping 2> /dev/null
    _RET=$?
done
/usr/bin/influx -precision rfc3339  -execute "create database \"${INFLUXDB_INITDB}\""
kill -s TERM $(cat ${PIDFILE})
/usr/bin/influxd -pidfile ${PIDFILE} -config ${CFGFILE}

# INFLUXDB_DATADIR
# INFLUXDB_INITDB
