#!/usr/bin/env bash

# Copyright (C) 2022 Roberto Rossini (roberros@uio.no)
# SPDX-License-Identifier: MIT

set -e
set -u
set -o pipefail

# Usage integration_test.sh path/to/bedtools_ng

# readlink -f is not available on macOS... Fall back using Python
# datadir="$(readlink -f "$(dirname "$0")/../data")"

function readlink_py () {
  python -c 'import os,sys;print(os.path.realpath(sys.argv[1]))' "$1"
}

datadir="$(readlink_py "$(dirname "$0")/../data")"

if [ $# -eq 0 ]; then
  bedtools_ng="$(which bedtools-ng)"
else
  bedtools_ng="$1"
fi

# Diff returns 1 when the two files differ
diff <(bedtools intersect -c -loj -a "$datadir/chroms.bed" -b "$datadir/grch38_transcripts.bed") \
     <("$bedtools_ng" count-overlaps "$datadir/chroms.bed" "$datadir/grch38_transcripts.bed" | cut -f 1-3,7)