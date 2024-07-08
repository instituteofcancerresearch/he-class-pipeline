#!/bin/sh

#SBATCH -J "HEBr"
#SBATCH -o outB/srun_b.out
#SBATCH -e outB/srun_b.err
#SBATCH -n 4
#SBATCH -t 100:00:00

module load MATLAB/R2020b
matlab -nodesktop -nosplash -r "addpath(genpath('./he-class-pipeline/codeb/')); CreateMaskTilesBatch('./outA/', './outB/', '"E"'); exit;"

