FROM mysql:5.7
COPY ./my.cnf /etc/my.cnf
COPY ./entrypoint.sh /tmp
RUN chmod u+x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
MAINTAINER <alex>
