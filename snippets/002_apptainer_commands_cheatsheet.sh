#!/usr/bin/env bash

# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

set -e

# Build an Apptainer image from a Docker image
# In this case, the Docker image is fetched from the local registry (notice the docker-daemon prefix)
# The -F flag tells apptainer to overwrite /tmp/cowsay_latest.sif (if such a file exists)
sudo apptainer build -F /tmp/cowsay_latest.sif docker-daemon://cowsay:latest

# Same as above, but this time we are pulling the Docker image from a remote registry (GHCR in this case.)
# Notice the prefix is now simply docker instead of docker-daemon
sudo apptainer build -F /tmp/cowsay_latest.sif docker://ghcr.io/sq-meetings-workshop-2022-04-01/cowsay:latest

# When omitting the registry URL (ghcr.io), both Docker and Apptainer pull the image from DockerHub
# The following will pull the latest ubuntu image from DockerHub
sudo apptainer build -F /tmp/ubuntu.sif docker://ubuntu:latest

# To run the entrypoint command specified in the Dockerfile used to generate the Docker image use the following
sudo apptainer run /tmp/cowsay_latest.sif 'Hi from Apptainer!'

# To run a custom command replace run with exec
sudo apptainer exec /tmp/cowsay_latest.sif echo '"$(hostname) $(whoami)"'
# The single quotes are needed in order for the subshell $(hostname) and $(whoami) to be expanded inside the container

# This is a shorcut for sudo apptainer exec /tmp/cowsay_latest.sif sh.
# It'll give you access to a shell running inside the container
sudo apptainer shell /tmp/cowsay_latest.sif

# On most setups, the host filesystem is mounted inside the Apptainer container, so that you can access files located
# on the host machine (try to run `sudo apptainer exec /tmp/cowsay_latest.sif ls ~`. You should see files from your home)
# It is of course possible to explicitly mount specific paths.
# The following will mount your home under /myhome inside the container
sudo apptainer exec -B "$HOME:/myhome" /tmp/cowsay_latest.sif ls -lah /myhome

# Same as above, but this time the mount is read-only (notice the write error)
sudo apptainer exec -B "$HOME:/myhome:ro" /tmp/cowsay_latest.sif bash -c 'ls -lah /myhome && touch /myhome/test'
# Here we are explicitly passing the commands to bash as string to avoid the following problem:
# Running sudo apptainer exec ... ls -lah /myhome && touch /myhome/test
# Would cause bash (on the host machine) to interpret expressions preceding && as a command,
# and expressions after && as another command.
# Thus ls -lah /myhome is executed inside the container and touch / mythome/test outside of it.
