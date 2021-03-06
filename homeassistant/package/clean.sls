# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import homeassistant with context %}

#include:
#  - {{ sls_config_clean }}

{%- if homeassistant.install_from_src %}

# {{ homeassistant.homedir }}:
#   file.absent

{{ homeassistant.user }}:
  user.absent:
    - purge: True
    - force: True

{%- else %}

homeassistant-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ homeassistant.pkg.name }}
    - require:
      #- sls: {{ sls_config_clean }}

{%- endif %}
