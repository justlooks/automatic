#!/bin/bash

CFGFILE="/opt/collectd/etc/collectd.conf"
CFGDIR="/opt/collectd/etc/collectd.d"

PERLPLUGINDIR="/opt/collectd/var/lib/collectd/Collectd/Plugins"  # this for perl Collectd::Plugins module

if [ ! -d "${CFGDIR}" ];then
        mkdir -p ${CFGDIR}
fi

mkdir -p ${PERLPLUGINDIR}

sed -i "/Server/s#[0-9.]\+#${INFLUXDB_IP}#" ${CFGFILE}
sed -i "/Hostname/s#localhost#${MONITOR_HOSTNAME}#" ${CFGFILE}

/opt/collectd/sbin/collectd -C /opt/collectd/etc/collectd.conf -f

# INFLUXDB_IP
# MONITOR_HOSTNAME
