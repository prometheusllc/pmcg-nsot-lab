#cloud-config
manage_resolve_conf: true
resolv_conf:
  nameservers: ['8.8.8.8', '4.2.2.4']
  options:
    rotate: true
    timeout: 1
hostname: "nsot"
packages:
  - build-essential
  - python-dev
  - libffi-dev
  - libssl-dev
  - python
  - python-pip
  - git
  - docker.io

runcmd:
  - export RDS_NAME=${RDS_NAME}
  - export RDS_USER=${RDS_USER}   
  - export RDS_PASS=${RDS_PASS} 
  - export RDS_HOST=${RDS_HOST}
  - export RDS_PORT=${RDS_PORT} 
  - export NSOT_EMAIL=${NSOT_EMAIL}
  - export NSOT_PASS=${NSOT_PASS}
  - export LOCAL_IP="$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')"
  - echo "$RDS_PORT $LOCAL_IP" >> test
  - cd /home/ubuntu
  - git clone https://github.com/prometheusllc/Docker-NSOT-Mysql.git
  - cd /home/ubuntu/Docker-NSOT-Mysql
  - docker build -t nsot:master .
  - docker run -itd --restart always --privileged --name nsot --net host -e RDS_NAME=$RDS_NAME \ 
  - -e RDS_USER=$RDS_USER -e RDS_PASS=$RDS_PASS -e RDS_HOST=$RDS_HOST -e  \ 
  - RDS_PORT=$RDS_PORT -e EMAIL=$NSOT_EMAIL -e PASS=NSOT_PASS nsot:master
