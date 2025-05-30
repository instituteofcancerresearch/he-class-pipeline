#!/bin/bash -l
#$ -N "HEDr"
#$ -o d_run.out
#$ -e d_run.err
#$ -l h_rt=24:00:00

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
cellDetectorCheckPointPath=${11} #"/home/regmna1/Scratch/Models/CellDetection/EPICC/Current/"
cellClassifierCheckPointPath=${12} #"/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellDetection/EPICC/Current/"
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

child_working_dir="$(pwd)/logsD"
echo "child_working_dir: $child_working_dir"

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
  var1="d_run_$counter.err"
  var2="d_run_$counter.out"  
  jabname="HEDr"  




  qsub -wd "$child_working_dir" -e "$var1" -o "$var2" "$pipe_path/sge_single.sh" \
  $image_file $base_image_file $code_path \
  $steps $conda_1 $conda_2 $tilePath \
  $segmentationTilePath \
  $cellDetectionResultsPath \
  $cellClassificationResultsPath \
  $cellDetectorCheckPointPath \
  $cellClassifierCheckPointPath
  ((counter++))
done

echo "Total = $counter"
