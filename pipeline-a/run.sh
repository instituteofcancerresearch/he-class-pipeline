#!/bin/sh
#SBATCH -J "HEAr"
#SBATCH -o a_run.out
#SBATCH -e a_run.err
#SBATCH -n 4
#SBATCH -t 100:00:00
source ~/.bashrc
singularity_path=$1
input_path=$2
output_path=$3
echo "Singularity path: $singularity_path"
echo "Input: $input_path"
echo "Output: $output_path"
# concat file path with file
singularity_path="$singularity_path/HEA.sif"
# run singularity
srun singularity run -B $input_path:/input -B $ouput_path:/output $singularity_path ./input ./output Y Y *.ndpi

