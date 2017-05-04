#!/bin/bash

CFGFILE="/etc/my.cnf"

sed -i "/^slow-query-log-file/s/=.*/= ${MYSQL_SLOWLOG}/" ${CFGFILE}
sed -i "/^innodb_buffer_pool_size/s/=.*/= ${MYSQL_POOLSIZE}/" ${CFGFILE}

mysqld --user=mysql


# MYSQL_SLOWLOG
# MYSQL_POOLSIZE
