# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "docker/map.jinja" import docker with context %}

{% if grains['os'] in ('Ubuntu', 'Debian') %}
apt-transport-https:
  pkg.installed:
    - refresh: true

docker-repo:
  pkgrepo.managed:
    - humanname: {{ docker.repo.humanname }}
    - name: {{ docker.repo.name }}
    - file: {{ docker.repo.file }}
    - keyid: {{ docker.repo.keyid }}
    - keyserver: {{ docker.repo.keyserver }}
    - gpgcheck: 1
    - require_in:
      - pkg: docker-pkg

{% elif grains['os'] == 'Raspbian' %}
  # Not supported yet
{% endif %}

docker-pkg:
  pkg.installed:
    - name: {{ docker.pkg }}
    - refresh: true

docker-compose-pip:
  pkg.installed:
    - name: python-pip
  pip.installed:
    - name: pip
    - upgrade: True

docker-compose:
  pip.installed:
    - name: docker-compose == {{ docker.compose.version }}

