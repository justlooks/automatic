# 从基本os镜像构建
FROM centos:6.9
COPY ./collectd-5.6.2.tar.gz /tmp/
RUN cd /tmp/ && tar xvf collectd-5.6.2.tar.gz
RUN yum -y update && yum install -y perl-ExtUtils-Embed perl-ExtUtils-MakeMaker perl-DBI perl-DBD-MySQL gcc
RUN cd /tmp/collectd-5.6.2 && ./configure && make install
# create sub-config file dir & plugins dir
RUN mkdir -p /opt/collectd/etc/collectd.d
RUN mkdir -p /opt/collectd/var/lib/collectd/Collectd/Plugins
COPY ./collectd/Collectd.pm  /opt/collectd/var/lib/collectd/
COPY ./collectd.conf /opt/collectd/etc/collectd.conf
MAINTAINER <alex>
