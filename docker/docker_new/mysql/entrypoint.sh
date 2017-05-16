#!/bin/bash

: "${MYSQL_SLOWLOG:=testme.log}"
: "${MYSQL_POOLSIZE:=512M}"

_get_config() {
        local conf="$1"
        mysqld --verbose --help 2>/dev/null | awk '$1=="'$conf'"{print $2;exit}'

}

CFGFILE="/etc/my.cnf"

sed -i "/^slow-query-log-file/s/=.*/= ${MYSQL_SLOWLOG}/" ${CFGFILE}
sed -i "/^innodb_buffer_pool_size/s/=.*/= ${MYSQL_POOLSIZE}/" ${CFGFILE}

if [ ! ${MYSQL_ROOT_PASSWORD} ];then
        echo "you should set the root password";exit 1
fi

DATADIR=$(_get_config 'datadir')

mkdir $(dirname ${DATADIR})

echo "Init database start..."
mysqld --user=mysql --initialize-insecure
echo "Init database finished"

echo "start user privilege settings.."
mysqld --user=mysql --skip-networking --socket="/tmp/mysql.sock" &
pid="$!"

for i in {30..0};do
        if echo 'SELECT 1' | mysql -uroot -S/tmp/mysql.sock &>/dev/null;then
                break
        fi
        sleep 1
done
echo "here $i"
if [ "$i" = 0 ]; then
        echo >&2 'MySQL init process failed.'
        exit 1
fi

mysql -uroot -S/tmp/mysql.sock <<-EOSQL
        -- following command should not be replicated
        SET @@SESSION.SQL_LOG_BIN=0;
        SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
        GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;
        DROP DATABASE IF EXISTS test ;
        FLUSH PRIVILEGES ;
EOSQL

echo "set .bashrc"
echo -e 'alias my3306=\047mysql -uroot -p${MYSQL_ROOT_PASSWORD} -S/tmp/mysql.sock --prompt="\u@\h:\d \\r:\m:\s>"\047' >> ~/.bashrc

if [ "${MYSQL_USER}" -a "${MYSQL_PASSWD}" -a "${MYSQL_USERIP}" ];then
        echo "CREATE USER '${MYSQL_USER}'@'${MYSQL_USERIP}' IDENTIFIED BY '${MYSQL_PASSWD}';" | mysql -uroot -S/tmp/mysql.sock -p${MYSQL_ROOT_PASSWORD}
        if [ "${MYSQL_USER_SCHEMA}" ];then
                echo "GRANT ALL ON ${MYSQL_USER_SCHEMA}.* TO '${MYSQL_USER}'@'${MYSQL_USERIP}';" | mysql -uroot -S/tmp/mysql.sock -p${MYSQL_ROOT_PASSWORD}
        fi
        echo "FLUSH PRIVILEGES;" | mysql -uroot -S/tmp/mysql.sock -p${MYSQL_ROOT_PASSWORD}
fi

if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MySQL init process failed.'
        exit 1
fi

echo "now run the database"
mysqld --user=mysql


# MYSQL_ROOT_PASSWORD     强制选项
# MYSQL_USER
# MYSQL_PASSWD
# MYSQL_USERIP
# MYSQL_USER_SCHEMA    值为*表示对所有schema授权
# MYSQL_SLOWLOG
# MYSQL_POOLSIZE
