# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import homeassistant with context %}

homeassistant-service-clean-service-dead:
  service.dead:
    - name: {{ homeassistant.service.name }}
    - enable: False
