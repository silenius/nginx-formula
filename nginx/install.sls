{% set nginx = salt.pillar.get('nginx') %}

nginx_pkg:
  pkg.installed:
    - name: {{ nginx.pkg }}
