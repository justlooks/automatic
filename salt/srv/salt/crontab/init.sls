/etc/crontab:
  file.managed:
    - source: salt://crontab/crontab
