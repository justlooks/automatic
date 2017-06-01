FROM centos:6.9
ADD ./prometheus-1.6.3.linux-amd64.tar /opt
COPY ./prometheus.yml /opt/prometheus-1.6.3.linux-amd64/
COPY ./entrypoint.sh /tmp
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
