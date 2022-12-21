FROM ubuntu:20.04

LABEL author="antonytayron@midgard.com.br"

#Use arm64 or amd64
ARG TARGETARCH

RUN echo "Building for $TARGETARCH"

RUN apt update \
&& apt install curl -y 

RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/$TARGETARCH/latest/salt-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=$TARGETARCH] https://repo.saltproject.io/py3/ubuntu/20.04/$TARGETARCH/latest focal main" | tee /etc/apt/sources.list.d/salt.list

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
&& apt-get install -y tzdata \
&& dpkg-reconfigure --frontend noninteractive tzdata \
&& rm -rf /var/lib/apt/lists

RUN apt update \
&& apt install -y python3 python3-pip salt-minion libssl-dev libffi-dev python-dev python-cffi \
&& rm -rf /var/lib/apt/lists

RUN pip install --upgrade pip \
&& pip install napalm

COPY proxy /etc/salt/proxy

COPY run-proxy.sh /usr/local/bin/run-proxy.sh

CMD "/usr/local/bin/run-proxy.sh"
