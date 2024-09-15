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

srun singularity run -B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs:/input -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA:/output /data/scratch/shared/SINGULARITY-DOWNLOAD/tools/.singularity/HEA.sif ./input ./output Y Y *.ndpi
#srun singularity run -B $input_path:/input -B $ouput_path:/output $singularity_path ./input ./output Y Y *.ndpi


if ! test -d /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier; 
then mkdir /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier; fi; 
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier;
export SINGULARITY_CACHEDIR=/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/.singularity;
export SINGULARITY_TMPDIR=/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/.singularity;
export APPTAINER_TMPDIR=/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/.singularity;
export APPTAINER_CACHEDIR=/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/.singularity;
mkdir -p /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC;
sbatch -o /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC/srun_c.out -e /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC/srun_c.err -J HECr --wrap="srun singularity run -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA:/input_tiles -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB:/target_tiles -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC:/output -B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/NormTiles/C4L/Tiles:/input_masks -B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/NormTiles/C4L/Masks:/target_masks HEC.sif /input_tiles /target_tiles /output /input_masks /target_masks *.*;";

