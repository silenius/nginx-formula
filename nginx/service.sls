include:
  - nginx.install

service_nginx:
  service.running:
    - name: nginx
    - enable: True
    - require:
      - pkg: nginx_pkg
