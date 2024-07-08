#!/bin/sh
#SBATCH -J "HEB"
#SBATCH -o /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outBsrun.out
#SBATCH -e /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outBsrun.err
#SBATCH -n 4
#SBATCH -t 100:00:00
module load MATLAB/R2020b
ImageTilesPath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA"
MaskTilesPath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB"
MaskMethod="E"
Params="jpg, [3.5 500 225]"
codePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/code/"
matlab -nodesktop -nosplash -r "addpath(genpath(/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/code)); CreateMaskTilesBatch(/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA, /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB, "E", "jpg,[3.5 500 225]"); exit;"
