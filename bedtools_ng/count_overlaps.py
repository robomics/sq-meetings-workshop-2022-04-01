# Copyright (C) 2022 Roberto Rossini <roberros@uio.no>
#
# SPDX-License-Identifier: MIT

import bioframe as bf


def count_overlaps(bed1, bed2, sort):
    """Count overlaps between two BED files"""
    data = bf.count_overlaps(bf.read_table(bed1, schema="bed"),
                             bf.read_table(bed2, schema="bed"))

    if sort:
        return bf.sort_bedframe(data)

    return data
