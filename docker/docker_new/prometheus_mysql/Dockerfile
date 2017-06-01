FROM localhost:5000/prometheus_agt:0.14.0
# copy current mysql install rpm package to docker image
COPY ./mysql-community-* /tmp/
COPY ./my.cnf /etc/my.cnf
COPY ./entrypoint.sh /tmp
ADD ./mysqld_exporter-0.10.0.linux-amd64.tar.gz /opt
RUN yum install -y /tmp/mysql*.rpm
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
