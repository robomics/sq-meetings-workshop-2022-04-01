#!/usr/bin/env bash

# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

set -e

# This script contains the command required to install bedtools-ng on an ubuntu machine
# Commands should be run from the repository's root

# Update repository metadata
sudo apt-get update

# Install dependencies
sudo apt-get install -y git                \
                        python3            \
                        python3-pip        \
                        python3-setuptools

# Install bedtools-ng
pip install '.[all]'

# Run unit tests
pytest .

# Run integration tests
scripts/integration_test.sh

# Check bedtools-ng was correctly installed

bedtools-ng --help
bedtools-ng --version

