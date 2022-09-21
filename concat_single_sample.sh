#!/bin/bash

# this script for concatenating a specific sample's reads 
# (mostly for testing purposes, don't use for more than a few files)

# final output is two fastq files, one for each paired end read

# input: either fastq or fastq.gz, whichever file type you are trying to concatenate

printf "\n"
echo "Input Type: $1"

printf "\n"
echo "Sample: $2"
SAMP=$2

printf "\n"
echo "Merging R1"
cat ${SAMP}_L00*_R1_001.$1 > ${SAMP}_ME_R1_001.$1

printf "\n"
echo "Merging R2"
cat ${SAMP}_L00*_R2_001.$1 > ${SAMP}_ME_R2_001.$1
