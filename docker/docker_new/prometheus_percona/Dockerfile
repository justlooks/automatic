FROM localhost:5000/prometheus_agt:0.14.0
# copy current mysql install rpm package to docker image
ADD ./Percona-Server-5.7.18-15-rbff2cd9-el6-x86_64-bundle.tar /tmp/
COPY ./my.cnf /etc/percona-server.conf.d/mysqld.cnf
COPY ./entrypoint.sh /tmp
ADD ./mysqld_exporter-0.10.0.linux-amd64.tar.gz /opt
RUN yum install -y /tmp/Percona-Server*.rpm
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
