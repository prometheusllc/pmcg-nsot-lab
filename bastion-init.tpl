#cloud-config
manage_resolve_conf: true
resolv_conf:
  nameservers: ['8.8.8.8', '4.2.2.4']
  options:
    rotate: true
    timeout: 1
hostname: "nsot-bastion"
packages:
  - build-essential
  - python-dev
  - libffi-dev
  - libssl-dev
  - python
  - python-pip
  - git
  - docker.io
  - traceroute
  - mtr

