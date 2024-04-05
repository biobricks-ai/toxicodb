import glob
import pandas as pd

csv_files = glob.glob("raw/*/*.csv")


def entrez_gid_zero(gid):
    if gid == "0":
        return None
    return gid


for file in csv_files:
    filename = file.split(".")[0]
    parquet_name = filename + ".parquet"
    csv = pd.read_csv(
        file, 
        keep_default_na=False, 
        converters={"entrez_gid": entrez_gid_zero}
    )
    csv.to_parquet(parquet_name)
