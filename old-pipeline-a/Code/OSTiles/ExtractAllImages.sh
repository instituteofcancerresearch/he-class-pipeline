#!/bin/bash
#VERSION v0.1

#Find NDPI etc and extract them

#$1 Source directory
#$2 Target

# bash ExtractAllImages.sh `pwd`
# find . -name "*.bsub" -exec bash -c "bsub < {}" \;

SAMPLES=`find ${1} -type f -name "*.ndpi"`
FULLDIRNAME=${1}
mkdir -p "${1}/bsub"
mkdir -p "${1}/cwserrors"
mkdir -p "${1}/cwsoutputs"

FULLDIRNAMEESC=$(echo $FULLDIRNAME | sed 's_/_\\/_g')
for s in $SAMPLES; do	
  echo "Create bsub for ${s}"
  BNAME=`basename ${s}`
  cp /mnt/scratch/users/molecpath/sraza/scripts/MyCodes/Generate_CWS/20181127_Generate_cws/header_CWS "${FULLDIRNAME}/bsub/${BNAME}_extract.bsub"
  sed -i "s/###NAME###/${BNAME}/g" "${FULLDIRNAME}/bsub/${BNAME}_extract.bsub"
  sed -i "s/###DIRNAME###/${FULLDIRNAMEESC}/g" "${FULLDIRNAME}/bsub/${BNAME}_extract.bsub"
done	

