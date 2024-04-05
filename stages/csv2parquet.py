import pandas as pd
import sys
import pyarrow as pyarrow
import fastparquet as fastparquet
import numpy as np

InFileName = sys.argv[1]
OutFileName = sys.argv[2]

def entrez_gid_zero(gid):
    if gid == '0':
        return None
    return gid

print(f"csv2parquet: Converting file {InFileName}")
DF = pd.read_csv(InFileName, sep=',', 
                 keep_default_na=False, 
                 # might need more precision than float64
                 # dtype={'expression': np.float64},
                 converters={'entrez_gid': entrez_gid_zero}
                 )
DF.to_parquet(OutFileName)
