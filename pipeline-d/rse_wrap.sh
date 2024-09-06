#!/bin/sh

image_dir=$1
code_path=$2
steps=$3

counter=0
for image_file in "$image_dir"/*
do
  echo "$image_file"
  var1="logs/he_$counter.err"
  var2="logs/he_$counter.out"
  sbatch --error=$var1 --output=$var2 rse_sbatch_single.sh $image_file $code_path $steps
  ((counter++))
done

echo $counter