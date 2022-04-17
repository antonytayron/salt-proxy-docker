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

    ```bash
    cd salt-proxy-docker
    ```

3. Start using it:

    ```bash
    docker build -t antonytayron/salt-proxy .
    ```


Run Image
-----

    docker run -it -e PROXYID=device -e MASTER=salt-master-IP-or-DNS antonytayron/salt-proxy

~~~~~~~~~~
This project is based on "mirceaulinic/salt-docker"
