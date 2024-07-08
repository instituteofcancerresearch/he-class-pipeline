#!/bin/sh

#SBATCH -J "HEBr"
#SBATCH -o srun_br.out
#SBATCH -e srun_br.err
#SBATCH -n 4
#SBATCH -t 100:00:00

module load MATLAB/R2020b
matlab -nodesktop -nosplash -r "addpath(genpath('./he-class-pipeline/codeb/')); CreateMaskTilesBatch('./outA/', './outB/', '"E"'); exit;"

