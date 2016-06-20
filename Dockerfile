FROM quay.io/nordstrom/baseimage-ubuntu:16.04
MAINTAINER Store Modernization Platform Team "invcldtm@nordstrom.com"

USER root

# gcc for cgo
RUN apt-get update -qy && \
    apt-get install -qy --no-install-recommends \
    curl \
    g++ \
    gcc \
    libc6-dev \
    git \
    make \
  && rm -rf /var/lib/apt/lists/*

ARG GOLANG_VERSION
ARG GOLANG_DOWNLOAD_SHA256

RUN curl -fsSL "https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" -o golang.tar.gz \
  && echo "${GOLANG_DOWNLOAD_SHA256}  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

USER ubuntu

WORKDIR $GOPATH

