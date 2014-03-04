#  create instance config file

{% for i in pillar['instancename'] %}

# copy start script

init_{{i}}:
  file.copy:
    - name: {{ pillar['start_file'] }}_{{ i }}
    - source: {{ pillar['start_file'] }}

tomcat_conf{{i}}:
  file.managed:
    - name: {{ pillar['tomcat_instance_confdir'] }}/tomcat_{{ i }}
    - template: jinja
    - source: salt://tomcat/my.conf
    - defaults:
       java_home: {{ pillar['java_home'] }}
       pid_file: {{ pillar['catalina_pidprefix'] }}/tomcat_{{ i }}.pid
       catalina_home: {{ pillar['catalina_home'] }}
       catalina_base: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}
       catalina_tmpdir: {{ pillar['catalina_tmpdirprefix'] }}/tomcat_{{ i }}/temp
       connector_port: {{ pillar['connector_port'] }}
       tomcat_log: {{ pillar['tomcat_logprefix'] }}/tomcat_{{ i }}.log
       tomcat_cfg: {{ pillar['tomcat_cfgprefix'] }}/tomcat_{{ i }}
       instance_name: tomcat_{{ i }}

base_{{i}}:
  file.directory:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}
    - user: root
    - group: tomcat
    - mode: 775
    - makedirs: True

conf_{{i}}:
  file.directory:
    - name: /etc/tomcat_{{ i }}
    - user: root
    - group: tomcat
    - mode: 775
    - makedirs: True

work_{{i}}:
  file.directory:
    - name: {{ pillar['catalina_tmpdirprefix'] }}/tomcat_{{ i }}/work
    - user: root
    - group: tomcat
    - mode: 775
    - makedirs: True

temp_{{i}}:
  file.directory:
    - name: {{ pillar['catalina_tmpdirprefix'] }}/tomcat_{{ i }}/temp
    - user: root
    - group: tomcat
    - mode: 775
    - makedirs: True

log_{{i}}:
  file.directory:
    - name: {{ pillar['tomcat_logprefix'] }}/tomcat_{{ i }}
    - user: root
    - group: tomcat
    - mode: 775
    - makedirs: True

webapps_{{i}}:
  file.directory:
    - name: {{ pillar['tomcat_deployprefix'] }}/tomcat_{{ i }}/webapps
    - user: root
    - group: tomcat
    - mode: 775
    - makedirs: True

# create symlink

sl_conf_{{i}}:
  file.symlink:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}/conf
    - target: /etc/tomcat_{{ i }}

sl_work_{{i}}:
  file.symlink:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}/work
    - target: {{ pillar['catalina_tmpdirprefix'] }}/tomcat_{{ i }}/work

sl_temp_{{i}}:
  file.symlink:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}/temp
    - target: {{ pillar['catalina_tmpdirprefix'] }}/tomcat_{{ i }}/temp

sl_log_{{i}}:
  file.symlink:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}/logs
    - target: {{ pillar['tomcat_logprefix'] }}/tomcat_{{ i }}

sl_webapps_{{i}}:
  file.symlink:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}/webapps
    - target: {{ pillar['tomcat_deployprefix'] }}/tomcat_{{ i }}/webapps

# copy server config file

serverxml_{{i}}:
  file.managed:
    - name: {{ pillar['catalina_baseprefix'] }}/tomcat_{{ i }}/conf/server.xml
    - template: jinja
    - source: salt://tomcat/server.xml.tmpl
    - defaults:
       shutdown_port: {{ pillar['shutdown_port'] }}
       connector_port: {{ pillar['connector_port'] }}
       ssl_port: {{ pillar['ssl_port'] }}
       ajp_port: {{ pillar['ajp_port'] }}

{% endfor %}

