zabbixrepo:
  file.managed:
    - name: /etc/yum.repos.d/zabbix.repo
    - source: salt://zabbix/zabbix.repo

zabbix-agent:
  pkg:
    - installed
    - require: 
      - file: zabbixrepo
  service.running:
    - require:
      - cmd: cmd-post

zabbixconff:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://zabbix/zabbix_agentd.conf
    - template: jinja
    - defaults:
       hostname: {{ grains['host'] }}
    - require:
      - pkg: zabbix-agent

cmd-post:
  cmd.run:
    - names:
      - /usr/bin/pkill zabbix_agen 
      - /sbin/chkconfig zabbix-agent on
    - require:
      - file: zabbixconff
