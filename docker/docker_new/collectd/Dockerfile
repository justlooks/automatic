# 从基本os镜像构建
FROM centos:6.9
COPY ./collectd-5.6.2.tar.gz /tmp/
RUN cd /tmp/ && tar xvf collectd-5.6.2.tar.gz
RUN yum -y update && yum install -y perl-ExtUtils-Embed perl-ExtUtils-MakeMaker gcc
RUN cd /tmp/collectd-5.6.2 && ./configure && make install
COPY ./collectd.conf /opt/collectd/etc/collectd.conf
COPY ./collectd.d/ /tmp/
COPY ./entrypoint.sh /tmp
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
