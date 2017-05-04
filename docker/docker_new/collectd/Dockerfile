FROM collectd:5.6.2
COPY ./collectd.conf /opt/collectd/etc/collectd.conf
COPY ./entrypoint.sh /tmp
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
