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
conda_dir=$5
tilePath=$6 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA"
segmentationTilePath=$7 #="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB"
cellDetectionResultsPath=$8 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD"
cellClassificationResultsPath=$9 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outE"
echo "*********INPUTS***********************"
echo "image_dir: $image_dir"
echo "pipe_path: $pipe_path"
echo "code_path: $code_path"
echo "steps: $steps"
echo "conda_dir: $conda_dir"
echo "tilePath: $tilePath"
echo "segmentationTilePath: $segmentationTilePath"
echo "cellDetectionResultsPath: $cellDetectionResultsPath"
echo "cellClassificationResultsPath: $cellClassificationResultsPath"

counter=0
for image_file in "$image_dir"/*
do
  base_image_file=$(basename $image_file)
  echo "BatchPath=$pipe_path/rse_sbatch_single.sh"
  echo "ImageFile=$image_file"  
  echo "BaseImageFile=$base_image_file"
  echo "CodePath=$code_path"
  echo "Steps=$steps"  
  var1="logsD/d_run_$counter.err"
  var2="logsD/d_run_$counter.out"  
  jabname="HEDr"  
  sbatch --error=$var1 --output=$var2 "$pipe_path/rse_sbatch_single.sh" $image_file $base_image_file $code_path $steps $conda_dir $tilePath $segmentationTilePath $cellDetectionResultsPath $cellClassificationResultsPath
  ((counter++))
done

echo $counter