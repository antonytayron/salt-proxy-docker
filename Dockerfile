FROM ubuntu:22.04

LABEL author="antonytayron@midgard.com.br"

#Use arm64 or amd64
ARG TARGETARCH

RUN echo "Building for $TARGETARCH"

RUN apt update \
&& apt install curl -y 

RUN curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring-2023.gpg https://repo.saltproject.io/salt/py3/ubuntu/22.04/$TARGETARCH/SALT-PROJECT-GPG-PUBKEY-2023.gpg \
&& echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=$TARGETARCH] https://repo.saltproject.io/salt/py3/ubuntu/22.04/$TARGETARCH/3006 jammy main" | tee /etc/apt/sources.list.d/salt.list

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
&& apt-get install -y tzdata \
&& dpkg-reconfigure --frontend noninteractive tzdata \
&& rm -rf /var/lib/apt/lists

RUN apt update && apt upgrade -y\
&& apt install -y python3 python3-pip salt-minion libssl-dev libffi-dev python3-dev python3-cffi \
&& rm -rf /var/lib/apt/lists

RUN pip install --upgrade pip \
&& pip install napalm

COPY proxy /etc/salt/proxy

COPY run-proxy.sh /usr/local/bin/run-proxy.sh

CMD "/usr/local/bin/run-proxy.sh"
