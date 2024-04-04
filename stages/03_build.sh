#!/usr/bin/env bash

# Script to process unzipped files and build parquet files

# Get local path
localpath=$(pwd)
echo "Local path: $localpath"

# Set list path
listpath="$localpath/list"
mkdir -p $listpath
echo "List path: $listpath"

# Set raw path
rawpath="$localpath/raw"
echo "Raw path: $rawpath"

# Create brick directory
brickpath="$localpath/brick"
mkdir -p $brickpath
echo "Brick path: $brickpath"

# Process raw files and create parquet files in parallel
# calling a Python function with arguments input and output filenames
find $rawpath -type f -name '*.csv' | xargs -P1 -n1 bash -c '
  relativepath=$(realpath --relative-to='$rawpath' $0)
  filename="${relativepath%.*}"
  parquetfile='$brickpath'/$filename.parquet
  mkdir -p $(dirname $parquetfile)
  echo $parquetfile
  python3 stages/csv2parquet.py $0 $parquetfile
'
