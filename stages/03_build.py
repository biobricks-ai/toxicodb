import pandas as pd
from pathlib import Path

def entrez_gid_zero(gid):
    if gid == "0":
        return None
    return gid

raw_path = Path('raw')

brick_path = Path('brick')

for infile in list( raw_path.rglob('*.csv') ):
    outfile = brick_path / infile.relative_to(raw_path).with_suffix('.parquet')
    outfile.parent.mkdir(parents=True, exist_ok=True)
    csv = pd.read_csv(
        infile, 
        keep_default_na=False, 
        converters={"entrez_gid": entrez_gid_zero}
    )
    csv.to_parquet(outfile)
