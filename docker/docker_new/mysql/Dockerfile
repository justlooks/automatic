FROM localhost:5000/collectd:5.6.2
# copy current mysql install rpm package to docker image
COPY ./mysql-community-* /tmp/
COPY ./my.cnf /etc/my.cnf
# copy init database script into image
COPY ./entrypoint.sh /tmp
RUN yum install -y /tmp/mysql*.rpm
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
