#!/usr/bin/env bash

# Script to unzip files

# Get local path
localpath=$(pwd)
echo "Local path: $localpath"

# Set download path
downloadpath="$localpath/download"
echo "Download path: $downloadpath"

# Create raw path
rawpath="$localpath/raw"
mkdir -p $rawpath
echo "Raw path: $rawpath"

# jq script
jq_script='.data 
| (map(keys) | add | unique) as $cols 
| map(. as $row | $cols | map($row[.])) as $rows 
| $cols, $rows[] 
| @csv'

< $downloadpath/compounds.json jq -r $jq_script > $rawpath/compounds.csv
< $downloadpath/genes.json jq -r $jq_script > $rawpath/genes.csv