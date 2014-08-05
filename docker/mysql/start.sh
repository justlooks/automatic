#!/bin/bash

if [ ! -d /data/db/mysql ];then
    echo build datadir
    mysql_install_db
    /usr/bin/mysqld_safe &
    sleep 10
    mysql -e "GRANT ALL ON *.* TO 'opr_sup'@'192.168.2.166' IDENTIFIED BY 'opr1' WITH GRANT OPTION;FLUSH PRIVILEGES"
    killall mysqld
    sleep 10s
fi
echo start mysql
/usr/bin/mysqld_safe

