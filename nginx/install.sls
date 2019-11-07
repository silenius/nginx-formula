{% from "nginx/map.jinja" import nginx with context %}

nginx_pkg:
  pkg.installed:
    - name: {{ nginx.pkg }}
