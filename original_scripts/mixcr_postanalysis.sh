#!/bin/bash

# Next, we will run postanalysis to get diversity measures for each individual sample file.

# Pairwise postanalysis can also be done, however are many combinations (n^2) for
# n samples 

# get clones files 
CLNS=`ls *.clns`
FIRST="TRUE"
TRUE="TRUE"

for SAMP in $CLNS
do
  mixcr postanalysis individual \
  --default-downsampling none \
  --default-weight-function none \
  --only-productive \
  --preproc-tables postanalysis_preproc/${SAMP}.preproc.tsv \
  --tables postanalysis_tables/${SAMP}.tsv \
  --chains TRB $SAMP "${SAMP}.TRB.json"

  mixcr postanalysis individual \
  --default-downsampling none \
  --default-weight-function none \
  --only-productive \
  --preproc-tables postanalysis_preproc/${SAMP}.preproc.tsv \
  --tables postanalysis_tables/${SAMP}.tsv \
  --chains TRAD $SAMP "${SAMP}.TRAD.json"

  if [ "$FIRST" = "$TRUE" ]; then
    FIRST="FALSE"
    cp postanalysis_tables/"${SAMP}.diversity.TRB.tsv" combined_diversity.TRB.tsv
    cp postanalysis_tables/"${SAMP}.diversity.TRAD.tsv" combined_diversity.TRAD.tsv
  else
    cat postanalysis_tables/"${SAMP}.diversity.TRB.tsv" >> combined_diversity.TRB.tsv
    cat postanalysis_tables/"${SAMP}.diversity.TRAD.tsv" >> combined_diversity.TRAD.tsv
  fi
done

mkdir diversity
mv combined_diversity* diversity/
