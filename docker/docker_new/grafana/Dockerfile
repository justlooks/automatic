FROM grafana:4.2
COPY ./grafana.ini /etc/grafana/grafana.ini
COPY ./entrypoint.sh /tmp
RUN chmod u+x /tmp/entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
