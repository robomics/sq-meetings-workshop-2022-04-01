# Copyright (C) 2022 Roberto Rossini <roberros@uio.no>
#
# SPDX-License-Identifier: MIT

import tempfile

from bedtools_ng.count_overlaps import count_overlaps


def test_count_overlaps():
    bed1 = (
        "chr1\t10\t20\n"
        "chr1\t30\t40\n"
    )

    bed2 = (
        "chr1\t15\t25\n"
        "chr1\t60\t70\n"
    )

    with tempfile.NamedTemporaryFile() as tmp1, tempfile.NamedTemporaryFile() as tmp2:
        with open(tmp1.name, "w") as f1, open(tmp2.name, "w") as f2:
            f1.write(bed1)
            f2.write(bed2)

        overlaps = count_overlaps(tmp1.name, tmp2.name, True)

    assert len(overlaps) == 2
    assert overlaps.loc[0, "count"] == 1
    assert overlaps.loc[1, "count"] == 0
