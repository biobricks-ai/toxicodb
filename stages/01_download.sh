#! /usr/bin/bash

localpath=$(pwd)
echo "Local path: $localpath"

# Create the list directory to save list of remote files and directories
downloadpath="$localpath/download"
echo "Download path: $downloadpath"
mkdir -p $downloadpath
cd $downloadpath;

# define URL file
l_url=(
    "https://bhkstaticfiles.blob.core.windows.net/toxicodb/TGGATEsHuman.zip"
    "https://bhkstaticfiles.blob.core.windows.net/toxicodb/TGGATEsRat.zip"
    "https://bhkstaticfiles.blob.core.windows.net/toxicodb/DrugMatrixRat.zip"
    "https://bhkstaticfiles.blob.core.windows.net/toxicodb/EMEXP2458.zip"
)

wget "https://www.toxicodb.ca/api/v1/compounds" -O compounds.json
wget "https://www.toxicodb.ca/api/v1/genes" -O genes.json

# Download files
for url in ${l_url[@]}; do
  wget $url
done

echo "Download done."