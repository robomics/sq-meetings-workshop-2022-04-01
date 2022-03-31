#!/usr/bin/env python

# Copyright (C) 2022 Roberto Rossini <roberros@uio.no>
#
# SPDX-License-Identifier: MIT

from __future__ import absolute_import

import argparse
import re
from pathlib import Path
from sys import stdout

from . import count_overlaps
from . import utils


def make_cli():
    from importlib.metadata import version

    cli = argparse.ArgumentParser()
    subparsers = cli.add_subparsers(help="subcmd", dest="command")
    subcmd = subparsers.add_parser("count-overlaps",
                                   help="Count the number of BED records from file B overlapping with records from file A.")

    ver = version(re.match(r"^[^.]+", __name__)[0])
    [c.add_argument("--version", action="version", version=f"%(prog)s v{ver}") for c in [cli, subcmd]]

    subcmd.add_argument("bed_files",
                        metavar="bed-files",
                        nargs=2,
                        type=Path,
                        help="Path to two or more BED files.")

    subcmd.add_argument("--sort",
                        default=False,
                        action="store_true",
                        help="Sort records before writing them to output.")

    return cli


def validate_args(cli, args):
    if args.command is None:
        cli.print_help()
        return False

    return True


def main():
    cli = make_cli()
    args = cli.parse_args()

    if not validate_args(cli, args):
        return 1

    df = count_overlaps.count_overlaps(*args.bed_files, sort=args.sort)
    utils.df_to_stdout(df, stdout)
    return 0


if __name__ == "__main__":
    main()
