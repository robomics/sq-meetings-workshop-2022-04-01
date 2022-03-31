# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

FROM ubuntu:20.04 as base

# Install dependencies
RUN apt-get update
RUN apt-get install -y git                \
                       python3            \
                       python3-pip        \
                       python3-setuptools

# Copy proj. inside container
COPY . /tmp/src

# Install and test proj.
RUN pip install '/tmp/src[all]'
RUN pytest /tmp/src

RUN bedtools-ng --help
RUN bedtools-ng --version

ENTRYPOINT ["/usr/local/bin/bedtools-ng"]

# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.authors='Roberto Rossini <roberros@uio.no>'
LABEL org.opencontainers.image.url='https://github.com/robomics/ci-and-docker-workshop'
LABEL org.opencontainers.image.source='https://github.com/robomics/ci-and-docker-workshop'
LABEL org.opencontainers.image.licenses='MIT'
LABEL org.opencontainers.image.title='bedtools-ng'
LABEL org.opencontainers.image.description='A silly Python replacement for BEDtools used to illustrate the use of Docker containers and GitHub actions'
