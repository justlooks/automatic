FROM localhost:5000/collectd:5.6.2
# copy current mysql install rpm package to docker image
COPY ./mysql-community-* /tmp/
COPY ./my.cnf /etc/my.cnf
COPY ./entrypoint.sh /tmp
COPY ./collectd/collectd-mysql.conf /opt/collectd/etc/collectd.d
COPY ./collectd/types.db /opt/collectd/share/collectd/
COPY ./plugin/Momysql.pm /opt/collectd/var/lib/collectd/Collectd/Plugins
RUN yum install -y /tmp/mysql*.rpm
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
