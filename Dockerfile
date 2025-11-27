FROM ubuntu:24.10

LABEL author="antonytayron@midgard.com.br"

#Use arm64 or amd64
ARG TARGETARCH

RUN echo "Building for $TARGETARCH"

RUN apt update && \
    apt install curl -y 

RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | sudo tee /etc/apt/keyrings/salt-archive-keyring.pgp && \
    curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | sudo tee /etc/apt/sources.list.d/salt.sources

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && \
    apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    rm -rf /var/lib/apt/lists

RUN apt update && apt upgrade -y && \
    apt install -y python3 python3-pip salt-minion libssl-dev libffi-dev python3-dev python3-cffi && \
    rm -rf /var/lib/apt/lists

RUN salt-pip install napalm

COPY proxy /etc/salt/proxy

COPY run-proxy.sh /usr/local/bin/run-proxy.sh

CMD ["/usr/local/bin/run-proxy.sh"]
