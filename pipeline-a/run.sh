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
# concat file path with file
singularity_path="$singularity_path/HEA.sif"
echo "Singularity path: $singularity_path"
echo "Input: $input_path"
echo "Output: $output_path"
# run singularity

srun singularity run -B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs:/input -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA:/output HEA.sif ./input ./output Y Y *.ndpi
#srun singularity run -B $input_path:/input -B $ouput_path:/output $singularity_path ./input ./output Y Y *.ndpi

