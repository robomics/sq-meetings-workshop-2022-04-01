# Copyright (C) 2022 Roberto Rossini <roberros@uio.no>
#
# SPDX-License-Identifier: MIT

from __future__ import absolute_import

import bedtools_ng.count_overlaps
import bedtools_ng.__main__

from importlib.metadata import version
import re

__version__ = version(re.match(r"^[^.]+", __name__)[0])
