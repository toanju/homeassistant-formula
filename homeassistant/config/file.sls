# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import homeassistant with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

homeassistant-config-file-file-managed:
  file.managed:
    - name: {{ homeassistant.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='homeassistant-config-file-file-managed'
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ homeassistant.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        homeassistant: {{ homeassistant | json }}
