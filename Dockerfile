# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

# Select a base image
FROM ubuntu:20.04

# Install some packages
RUN apt-get update \
&&  apt-get install -y cowsay      \
                       python3-pip
# Install some more packages
RUN pip3 install cowsay

# Configure environment e.g. by running some commands
RUN cowsay 'I like whales!'
RUN python3 -c 'import cowsay; cowsay.cow("I prefer pythons!")'

# Copy some files from the host machine to the container
COPY LICENSE /usr/share/doc/mycowsay/copyright

ENTRYPOINT ["cowsay"]

# Add some labels (optional, but recommended)
# https://github.com/opencontainers/image-spec/blob/main/annotations.md#pre-defined-annotation-keys
LABEL org.opencontainers.image.authors='Roberto Rossini <roberros@uio.no>'
LABEL org.opencontainers.image.url='https://github.com/robomics/ci-and-docker-workshop'
LABEL org.opencontainers.image.source='https://github.com/robomics/ci-and-docker-workshop'
LABEL org.opencontainers.image.licenses='MIT'
LABEL org.opencontainers.image.title='cowsay'
LABEL org.opencontainers.image.description='Mooo'
