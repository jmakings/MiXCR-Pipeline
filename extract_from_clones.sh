CLNS=`ls *.clns`

for SAMP in $CLNS
do
  BASE=${SAMP%.*}

  mixcr exportClones \
  --chains TRB \
  -p full \
  -lengthOf CDR3 \
  -nFeature VCDR3Part \
  -nFeature VDJunction \
  -nFeature DCDR3Part \
  -nFeature DJJunction \
  -nFeature JCDR3Part \
  -nFeature VJJunction \
  -avrgFeatureQuality CDR3 \
  -vHit -vGene -vHitScore \
  -dHit -dGene -dHitScore \
  -jHit -jGene -jHitScore \
  -cHit -cGene -cHitScore \
  ${SAMP} ${BASE}_TRB_full.tsv

  mixcr exportClones \
  --chains TRAD \
  -p full \
  -lengthOf CDR3 \
  -nFeature VCDR3Part \
  -nFeature VDJunction \
  -nFeature DCDR3Part \
  -nFeature DJJunction \
  -nFeature JCDR3Part \
  -nFeature VJJunction \
  -avrgFeatureQuality CDR3 \
  -vHit -vGene -vHitScore \
  -dHit -dGene -dHitScore \
  -jHit -jGene -jHitScore \
  -cHit -cGene -cHitScore \
  ${SAMP} ${BASE}_TRAD_full.tsv
done
