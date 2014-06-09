zookeeper:
  pkg.installed:
    - skip_verify: False

zookeeper-server:
  pkg.installed

/etc/zookeeper/conf/zoo.cfg:
  file.managed:
   - source: salt://zookeeper/zoo.cfg
   - template: jinja
   - require:
      - pkg: zookeeper
   - defaults:
       maxcliconns: {{pillar['maxcliconns']}}
       ticktime: {{pillar['ticktime']}}
       initlimit: {{pillar['initlimit']}}
       synclimit: {{pillar['synclimit']}}
       datadir: {{pillar['datadir']}}
       clientport: {{pillar['clientport']}}
       snapretaincnt: {{pillar['snapretaincnt']}}
       purgeintervalhour: {{pillar['purgeintervalhour']}}

service zookeeper-server init --myid={% for i in pillar['cluster'] %}{% set judge = i.split(':')[-1] %}{% if judge == grains['ip_interfaces'][pillar['interface']][0] %}{{i.split(':')[0]}}{% endif %}{% endfor %}:
  cmd.run:
    - require:
       - pkg: zookeeper-server
