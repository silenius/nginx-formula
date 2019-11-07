include:
  - nginx.install
  - nginx.service

{% set nginx = salt.pillar.get('nginx') %}

nginx_conf:
  file.managed:
    - name: {{ nginx.conf_dir | path_join(nginx.conf_file) }}
    - source: {{ nginx.conf_file_template }}
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - watch_in:
      - service: nginx

nginx_include_dir:
  file.directory:
    - name: {{ nginx.includes_dir }}
    - user: root
    - group: wheel
    - mode: 644
    - require:
      - pkg: nginx_pkg

{% for conf_file, params in nginx.include_files.items() %}
nginx_{{ conf_file }}:
  file.managed:
    - name: {{ nginx.includes_dir | path_join(conf_file) }}
    - source : {{ params.template }}
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - require:
      - file: nginx_include_dir
    - watch_in:
      - service: nginx
{% endfor %}
