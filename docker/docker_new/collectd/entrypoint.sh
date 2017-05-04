#!/bin/bash

CFGFILE="/opt/collectd/etc/collectd.conf"

sed -i "/Server/s/[0-9.]\+/${INFLUXDB_IP}/" ${CFGFILE}

/opt/collectd/sbin/collectd -C /opt/collectd/etc/collectd.conf

# INFLUXDB_IP
