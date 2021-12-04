FROM ubuntu:20.04

MAINTAINER antonytayron@midgard.com.br

RUN apt update && apt install curl -y

RUN curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/20.04/arm64/latest/salt-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=arm64] https://repo.saltproject.io/py3/ubuntu/20.04/arm64/latest focal main" | tee /etc/apt/sources.list.d/salt.list

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
&& apt-get install -y tzdata \
&& dpkg-reconfigure --frontend noninteractive tzdata

RUN apt update && apt install -y python3 python3-pip salt-minion libssl-dev libffi-dev python-dev python-cffi

#RUN pip install --upgrade pip \
#&& pip install --upgrade pip setuptools wheel \
#&& pip install p5py \
#&& pip install PEP517 \
#&& pip install napalm

COPY dist-packages/ /usr/local/lib/python3/

#RUN pip install napalm

## Copy the Proxy config file
ADD proxy /etc/salt/proxy

# Add Run File
ADD run-proxy.sh /usr/local/bin/run-proxy.sh

# Run Command
CMD "/usr/local/bin/run-proxy.sh"
