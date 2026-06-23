#!/bin/bash

# this script for concatenating all lanes for each paired end read together

# final output is two fastq files, one for each paired end read

# input: either fastq or fastq.gz, whichever file type you are trying to concatenate

printf "\n"
echo "Input Type: $1"

FASTQs=`ls *.$1`

SAMPVEC=$( ls $FASTQs | sed 's!.*/!!' | awk '{m=split($0,a,"_L"); for(i=1;i<m;i++)printf a[i]}; {print ""}' | sort | uniq )

for SAMP in $(echo $SAMPVEC)
do
  printf "\n"
  echo $SAMP

  printf "\n"
  echo "Merging R1"
  cat ${SAMP}_L00*_R1_001.$1 > ${SAMP}_ME_R1_001.$1
  
  printf "\n"
  echo "Merging R2"
  cat ${SAMP}_L00*_R2_001.$1 > ${SAMP}_ME_R2_001.$1
done

