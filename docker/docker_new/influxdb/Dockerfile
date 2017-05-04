FROM influxdb:1.2.2
COPY ./influxdb.conf /etc/influxdb/influxdb.conf
COPY ./entrypoint.sh /tmp
COPY ./types.db /tmp
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
