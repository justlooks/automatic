/etc/logrotate.d/mysql:
  file.managed:
    - source: salt://logrotate/mysql
    - template: jinja
    - defaults:
       hostname: {{ grains['host'] }}
