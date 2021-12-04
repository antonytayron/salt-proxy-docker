salt-Proxy-docker
===========

A collection of Docker files and other script to easily manage my own Salt 
development environment.

Usage
-----

1. Clone this repo:

   .. code-block:: bash

     git clone git@github.com:antonytayron/salt-proxy-docker.git

2. Change dir:

   .. code-block:: bash

     cd salt-proxy-docker

3. In Dockerfile Change de architecture (amd64 or arm64):

   .. code-block:: bash

      FROM ubuntu:20.04

      MAINTAINER antonytayron@midgard.com.br

      RUN apt update && apt install curl -y

      RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/arm64/latest/salt-archive-keyring.gpg \
      && echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=arm64] https://repo.saltproject.io/py3/ubuntu/20.04/arm64/latest focal main" | tee /etc/apt/sources.list.d/salt.list

      RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
      && apt-get install -y tzdata \
      && dpkg-reconfigure --frontend noninteractive tzdata

      RUN apt update && apt install -y python3 python3-pip salt-minion libssl-dev libffi-dev python-dev python-cffi

      RUN pip install --upgrade pip \
      && pip install napalm

      ADD proxy /etc/salt/proxy

      ADD run-proxy.sh /usr/local/bin/run-proxy.sh

      CMD "/usr/local/bin/run-proxy.sh"

4. Start using it:

   .. code-block:: bash

     docker build -t antonytayron/salt-proxy .

=====================
This project is based on "mirceaulinic/salt-docker"
