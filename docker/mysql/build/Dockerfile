# example for change yum
FROM docker:5000/centos:base
MAINTAINER Alex Kim <alex_kim@mediaadx.com>
RUN rm /etc/yum.repos.d/*
RUN wget -O- ftp://192.168.10.207/yum.repod/centos65.repo > /etc/yum.repos.d/centos65.repo

# configure for mysql server&client
RUN yum install -y mysql mysql-server
RUN rm /etc/my.cnf
RUN wget -O- ftp://192.168.10.207/docker/mysql/my.cnf > /etc/my.cnf
RUN wget -O- ftp://192.168.10.207/docker/mysql/start.sh > /opt/start.sh
EXPOSE 3306
CMD ["/bin/bash", "/opt/start.sh"]

