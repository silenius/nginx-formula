{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.install

service_nginx:
  service.running:
    - name: {{ nginx.service }}
    - enable: True
    - require:
      - pkg: {{ nginx.pkg }}
