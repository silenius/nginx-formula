{% from "nginx/map.jinja" import nginx with context %}

include:
  - nginx.install
  - nginx.service

nginx_conf:
  file.managed:
    - name: {{ nginx.conf_file }}
    - source: {{ nginx.conf_file_template }}
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - watch_in:
      - service: {{ nginx.service }}

nginx_include_dir:
  file.directory:
    - name: {{ nginx.includes_dir }}
    - user: root
    - group: wheel
    - mode: 644
    - require:
      - pkg: {{ nginx.pkg }}

{% for conf_file, params in nginx.includes.items() %}
nginx_{{ conf_file }}:
  file.managed:
    - name: {{ nginx.includes_dir | path_join(conf_file) }}
    - source : {{ params.template }}
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
    - defaults: 
      - cfg: {{ params.config | tojson }}
    - require:
      - file: nginx_include_dir
    - watch_in:
      - service: {{ nginx.service }}
{% endfor %}
