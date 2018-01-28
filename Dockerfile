FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
        build-essential \
        libtool \
        autotools-dev \
        automake \
        pkg-config \
        libssl-dev \
        libevent-dev \
        bsdmainutils \
        git \
        cmake \
        libboost-all-dev \
        software-properties-common

RUN add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    apt-get install -y libdb4.8-dev libdb4.8++-dev

ADD sirius /sirius

WORKDIR /sirius
RUN ./autogen.sh && ./configure && make -j$(nproc)

WORKDIR /sirius
RUN cp src/sirius-cli /usr/bin/sirius-cli
RUN cp src/siriusd /usr/bin/siriusd

CMD ["/usr/bin/siriusd"] 
