# example for change yum
FROM docker:5000/centos:base
MAINTAINER Alex Kim <alex_kim@mediaadx.com>
RUN rm /etc/yum.repos.d/*
RUN wget -O- ftp://192.168.10.207/yum.repod/centos65.repo > /etc/yum.repos.d/centos65.repo

# configure for java1.7 openjdk
RUN yum install -y java-1.7.0-openjdk
