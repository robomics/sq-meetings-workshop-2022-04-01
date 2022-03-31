# Copyright (C) 2022 Roberto Rossini <roberros@uio.no>
#
# SPDX-License-Identifier: MIT

def df_to_stdout(df, output_file):
    assert df is not None
    df.to_csv(output_file,
              sep="\t",
              na_rep=".",
              index=False,
              header=False)
