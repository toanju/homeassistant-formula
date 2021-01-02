# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import homeassistant with context %}

{%- if homeassistant.install_from_src %}

homeassistant-src-dependencies-install-pkg-installed:
  pkg.installed:
    - pkgs: {{ homeassistant.src.pkgs }}

{{ homeassistant.user }}:
  user.present:
    - shell: /bin/bash
    - home: {{ homeassistant.homedir }}
    - system: True
    - groups: {{ homeassistant.src.groups }}

{{ homeassistant.homedir}}/.venv:
  virtualenv.managed:
    - pip_pkgs: {{ homeassistant.src.name }}
    - user: {{ homeassistant.user }}
    - require:
      - user: {{ homeassistant.user }}
      - pkg: homeassistant-src-dependencies-install-pkg-installed

{%- else %}

homeassistant-package-install-pkg-installed:
  pkg.installed:
    - name: {{ homeassistant.pkg.name }}

{%- endif %}
