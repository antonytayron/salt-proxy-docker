salt-Proxy-docker
===========

[![Salt-Proxy on Docker CI](https://github.com/antonytayron/salt-proxy-docker/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/antonytayron/salt-proxy-docker/actions/workflows/docker-image.yml)

Usage
-----

1. Clone this repo:
  
    ```bash
    git clone git@github.com:antonytayron/salt-proxy-docker.git
    ```

2. Change dir:

   .. code-block:: bash

     cd salt-proxy-docker

3. In Dockerfile Change de architecture var (amd64 or arm64).

4. Start using it:

   .. code-block:: bash

     docker build -t antonytayron/salt-proxy .


Run Image
-----

   .. code-block:: bash
   
     docker run -it -e PROXYID=device -e MASTER=salt-master-IP-or-DNS antonytayron/salt-proxy



~~~~~~~~~~

This project is based on "mirceaulinic/salt-docker"
