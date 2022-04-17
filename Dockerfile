FROM ubuntu:20.04

LABEL author="antonytayron@midgard.com.br"

#Use arm64 or amd64
ARG TARGETARCH

RUN 

echo "I'm building for $TARGETPLATFORM"

RUN apt update && apt install curl -y

RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/$ARCH/latest/salt-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=$ARCH] https://repo.saltproject.io/py3/ubuntu/20.04/$ARCH/latest focal main" | tee /etc/apt/sources.list.d/salt.list

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
&& apt-get install -y tzdata \
&& dpkg-reconfigure --frontend noninteractive tzdata

RUN apt update && apt install -y python3 python3-pip salt-minion libssl-dev libffi-dev python-dev python-cffi

RUN pip install --upgrade pip \
&& pip install napalm

ADD proxy /etc/salt/proxy

ADD run-proxy.sh /usr/local/bin/run-proxy.sh

CMD "/usr/local/bin/run-proxy.sh"