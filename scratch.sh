#!/bin/sh
#SBATCH -p gpu
#SBATCH -J "HEDri"
#SBATCH -t 12:00:00
#SBATCH --gres=gpu:1

source /data/scratch/shared/RSE/sources/.nick
#module load anaconda/3
source activate /data/rds/DIT/SCICOM/SCRSE/shared/conda/tfAlmaGPU1p4
echo "Python version: $(python --version)"
echo "Python path: $(which python)"