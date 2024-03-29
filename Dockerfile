FROM nvidia/cuda:11.4.2-base-ubuntu20.04

ENV NVIDIA_DRIVER_CAPABILITIES="compute,video,utility"

ENV WALLET=NHbKJHcy4QbMcrHihhWgCwN4EcZBCB4i9FMn
ENV SERVER=stratum+tcp://kawpow.auto.nicehash.com:9200
ENV WORKER=ADEL
ENV ALGO=kawpow
ENV PASS=x
ENV API_PASSWORD=Password1

ENV TREX_URL="https://github.com/trexminer/T-Rex/releases/download/0.26.8/t-rex-0.26.8-linux.tar.gz"

ADD config/config.json /home/nobody/

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget libnvidia-ml-dev \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /trex \
    && wget --no-check-certificate $TREX_URL \
    && tar -xvf ./*.tar.gz  -C /trex \
    && rm *.tar.gz

WORKDIR /trex

ADD init.sh /trex/

VOLUME ["/config"]

CMD ["/bin/bash", "init.sh"]
