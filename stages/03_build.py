import pandas as pd
import os
import pathlib

def entrez_gid_zero(gid):
    if gid == "0":
        return None
    return gid

os.makedirs("brick", exist_ok=True)

csv_files = pathlib.Path("raw").rglob("*.csv")

f = list( pathlib.Path('raw').rglob('*/*.csv') )[0]
f.name.replace('.csv', '.parquet')
pathlib.Path('brick') / f.relative_to('raw')

for file in csv_files:
    filename = file.name.replace(".csv", ".parquet")
    csv = pd.read_csv(
        file, 
        keep_default_na=False, 
        converters={"entrez_gid": entrez_gid_zero}
    )
    csv.to_parquet(filename)
