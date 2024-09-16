#!/bin/sh

image_dir=$1
code_path=$2
steps=$3

counter=0
for image_file in "$image_dir"/*
do
  echo "ImageFile=$image_file"
  echo "CodePath=$code_path"
  var1="d_run_$counter.err"
  var2="d_run_$counter.out"
  sbatch --error=$var1 --output=$var2 "$code_path/rse_sbatch_single.sh" $image_file $code_path $steps
  ((counter++))
done

echo $counter