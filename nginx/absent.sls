{% from "nginx/map.jinja" import nginx with context %}

service_nginx:
  service.dead:
    - name: {{ nginx.service }}
    - enable: False
    - prereq:
      - pkg: {{ nginx.pkg }}

nginx_pkg:
  pkg.removed:
    - name: {{ nginx.pkg }}

nginx_conf:
  file.absent:
    - name: {{ nginx.conf_dir }}
    - require:
      - pkg: {{ nginx.pkg }}
