#!/bin/sh

#SBATCH -J "ClassifyEPICC"
#SBATCH -a 1-5
#SBATCH -p gpu
#SBATCH -e /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/ClassifyEPICC.errors.%A_%a
#SBATCH -o /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/ClassifyEPICC.output.%A_%a
#SBATCH -t 12:00:00
#SBATCH --gres=gpu:1

module load anaconda/3
module load MATLAB/R2020b

/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Code/DeepLearningStuff/PipelineScripts/EPICCCellClassification.sh $((SLURM_ARRAY_TASK_ID-1))
