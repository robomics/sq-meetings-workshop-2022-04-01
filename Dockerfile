# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

FROM ubuntu:20.04 as builder

COPY .           /tmp/src/

# Install dependencies
RUN apt-get update \
&&  apt-get install -y git                \
                       python3            \
                       python3-pip        \
                       python3-venv       \
                       python3-setuptools

# Install and test proj.
RUN pip install '/tmp/src[all]' \
&&  pytest /tmp/src

# Create venv
RUN python3 -m venv /opt/bedtools-ng --upgrade \
&&  /opt/bedtools-ng/bin/pip3 install /tmp/src

# IMPORTANT: New build stage! Switch to new base
FROM ubuntu:20.04 as base

# Copy venv from previous build stage
COPY --from=builder /opt/bedtools-ng /opt/bedtools-ng

# Install runtime dependencies
RUN apt-get update \
&&  apt-get install -y python3 \
&&  rm -rf /var/lib/apt/lists/*

# Add venv bin/ folder to PATH
# Notice that here we use ENV instead of ARG.
# Varibles defined with ENV remain available once the container is built
ENV PATH="/opt/bedtools-ng/bin:$PATH"

RUN  bedtools-ng --help
RUN  bedtools-ng --version

ENTRYPOINT ["/opt/venv/bin/bedtools-ng"]

# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.authors='Roberto Rossini <roberros@uio.no>'
LABEL org.opencontainers.image.url='https://github.com/robomics/ci-and-docker-workshop'
LABEL org.opencontainers.image.source='https://github.com/robomics/ci-and-docker-workshop'
LABEL org.opencontainers.image.licenses='MIT'
LABEL org.opencontainers.image.title='bedtools-ng'
LABEL org.opencontainers.image.description='A silly Python replacement for BEDtools used to illustrate the use of Docker containers and GitHub actions'
