{{ tpldot }}.repo:
  pkgrepo.managed:
    - humanname: Docker Repository
    - name: deb https://download.docker.com/linux/ubuntu {{ salt['grains.get']('oscodename') }} stable
    - dist: {{salt['grains.get']('oscodename')}}
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg
    - clean_file: true
    - refresh: true

{{ tpldot }}.packages.installed:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-compose-plugin
    - require:
      - pkgrepo: {{ tpldot }}.repo


{% if not salt['file.file_exists']('/etc/docker/daemon.json') %}
/etc/docker/daemon.json:
  file:
    - managed
    - source: salt://{{ tpldir }}/files/daemon.json
{% endif %}
