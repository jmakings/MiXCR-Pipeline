#!/bin/bash

# this script to obtain the merged FASTQs only and run MiXCR on the merged files
# specific for merged files created previously (with ${SAMP}_ME_R1_001)
# run in the same directory that FASTQs are located

# get fastq files
FASTQs=`ls *ME*`

# File Extensions
SAMPVEC=$( ls $FASTQs | sed 's!.*/!!' | awk '{m=split($0,a,"_M"); for(i=1;i<m;i++)printf a[i]}; {print ""}' | sort | uniq )

#Getting the paired samples as input

for SAMP in $( echo $SAMPVEC );
do  
  printf "\n"
  echo "SAMPLE##################"
  echo $SAMP

  MR1="${SAMP}_ME_R1_001.fastq.gz"
  MR2="${SAMP}_ME_R2_001.fastq.gz"

  echo $MR1
  echo $MR2
  NAME="${SAMP:7:-1}"

  echo "Final Sample Name: ${NAME}"
  
## MIXCR RUN

# Creates 4 types of files:
# .vdjca files with binary alignments (many for each sample)
# .clns files with binary clonotype information (one per sample),
# report files that provide overview of alignment, assembly, extension steps
# and finally .tsv with clonotype information (one for each TCR chain type)
  mixcr analyze shotgun -s hsa \
  --starting-material rna --report ${NAME}_report.txt \
  --receptor-type tcr $MR1 $MR2 ${NAME}
done
