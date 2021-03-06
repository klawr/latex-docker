# <=======================================  base  =======================================>
FROM debian:stable-slim as base
LABEL maintainer="mail@kailawrence.de"

RUN apt-get -y -q update && apt-get -y -q install perl fonts-noto

# <======================================= builder =======================================>
FROM base as builder

RUN apt-get -y -q install wget
ADD https://ctan.math.illinois.edu/systems/texlive/tlnet/install-tl-unx.tar.gz /tmp/install.tar.gz
WORKDIR /tmp
RUN tar -xzf /tmp/install.tar.gz

WORKDIR /opt/texlive
ADD texlive.profile .
RUN perl /tmp/install-tl*/install-tl -profile=texlive.profile
RUN ./bin/x86_64-linux/tlmgr update --all

# <======================================= final  =======================================>
FROM base as final
COPY --from=builder /opt /opt

ENV PATH="/opt/texlive/bin/x86_64-linux:${PATH}"
WORKDIR /data
