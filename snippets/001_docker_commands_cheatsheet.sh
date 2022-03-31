#!/usr/bin/env bash

# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

set -e

# Build a Dockerfile located in the current working directory
# and tag the resulting image with a couple of tags using the -t flags
# -f Dockerfile can be omitted if the Dockerfile is located in the current working directory
sudo docker build -t cowsay:latest \
                  -t cowsay:1.2.3  \
                  -f Dockerfile    \
                  .

# Run a container using the image built in the previous step
# This will by default run the command specified as entrypoint in the Dockerfile
sudo docker run cowsay:latest 'Hello from inside the container!'

# Run a container using the image from the first step using a custom entrypoint
# (bash in this case).
# -it will cause Docker to start the container in interactive mode
# --rm will delete the container (but not the image!) upon exit
# --entrypoint is used to override the default entrypoint
sudo docker run -it                  \
                --rm                 \
                --entrypoint /bin/sh \
                cowsay:latest

# Export an image. Docker save by defaults writes a tar archive to stdout.
# Here we compress the stdout using pigz
sudo docker save cowsay:latest | pigz -9 > cowsay_latest.tar.gz

# Import the image exported in the previous step
gzip -dc cowsay_latest.tar.gz | sudo docker load

# Pull an image from a remote registry (DockerHub in this case)
sudo docker pull ubuntu:latest

# Run some commands using the Ubuntu image we just downloaded
sudo docker run -it --rm ubuntu:latest bash -c 'pwd && ls -lah'

# It is not necessary to manually pull a container before using it
sudo docker run -it --rm fedora:latest bash -c 'pwd && ls -lah'

# Wipe pretty much all data created by Docker (including images and containers)
sudo docker system prune -a

