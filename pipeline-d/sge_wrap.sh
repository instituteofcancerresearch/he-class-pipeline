#!/bin/sh
#$ -N "HEDr"
#$ -o d_run.out
#$ -e d_run.err
#$ -pe smp 4
#$ -l h_rt=100:00:00

image_dir=$1
pipe_path=$2
code_path=$3
steps=$4
conda_1=$5
conda_2=$6
tilePath=$7 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA"
segmentationTilePath=$8 #="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB"
cellDetectionResultsPath=$9 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD"
cellClassificationResultsPath=${10} #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outE"
echo "*********INPUTS***********************"
echo "old_wrap.sh"
echo "image_dir: $image_dir"
echo "pipe_path: $pipe_path"
echo "code_path: $code_path"
echo "steps: $steps"
echo "conda_1: $conda_1"
echo "conda_2: $conda_2"
echo "tilePath: $tilePath"
echo "segmentationTilePath: $segmentationTilePath"
echo "cellDetectionResultsPath: $cellDetectionResultsPath"
echo "cellClassificationResultsPath: $cellClassificationResultsPath"

counter=0
for image_file in "$image_dir"/*
do
  echo "$counter ---------------------------"
  base_image_file=$(basename $image_file)
  echo "BatchPath=$pipe_path/old_sbatch_single.sh"
  echo "ImageFile=$image_file"  
  echo "BaseImageFile=$base_image_file"
  echo "CodePath=$code_path"
  echo "Steps=$steps"  
  var1="logsD/d_run_$counter.err"
  var2="logsD/d_run_$counter.out"  
  jabname="HEDr"  
  sbatch --error=$var1 --output=$var2 "$pipe_path/sge_single.sh" $image_file $base_image_file $code_path $steps $conda_1 $conda_2 $tilePath $segmentationTilePath $cellDetectionResultsPath $cellClassificationResultsPath
  ((counter++))
done

echo "Total = $counter"