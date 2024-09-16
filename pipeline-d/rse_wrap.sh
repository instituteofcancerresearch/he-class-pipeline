#!/bin/sh
#SBATCH -J "HEDwr"
#SBATCH -o d_run.out
#SBATCH -e d_run.err
#SBATCH -n 4
#SBATCH -t 100:00:00

image_dir=$1
pipe_path=$2
code_path=$3
steps=$4

counter=0
for image_file in "$image_dir"/*
do
  echo "BatchPath=$pipe_path/rse_sbatch_single.sh"
  echo "ImageFile=$image_file"  
  echo "CodePath=$code_path"
  echo "Steps=$steps"  
  var1="d_run_$counter.err"
  var2="d_run_$counter.out"  
  sbatch --error=$var1 --output=$var2 "$pipe_path/rse_sbatch_single.sh" $image_file $code_path $steps
  ((counter++))
done

echo $counter