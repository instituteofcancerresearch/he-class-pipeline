#!/bin/sh

#SBATCH -J "HEBr"
#SBATCH -o /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/outB/srun_b.out
#SBATCH -e /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/outB/srun_b.err
#SBATCH -n 4
#SBATCH --mail-type="END,FAIL"
#SBATCH -t 100:00:00

module load MATLAB/R2020b

#ImageTilesPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/AdInCar/ICR/Tiles/"
ImageTilesPath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/outA/"
#MaskTilesPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/AdInCar/ICR/Masks/"
MaskTilesPath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/outB/"

MaskMethod="E";
Params="'jpg', [3.5 500 225]"

#codePath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Code/MaskTiles/"
codePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/codeb/"



module load MATLAB

matlab -nodesktop -nosplash -r "addpath(genpath('${codePath}')); CreateMaskTilesBatch('$ImageTilesPath', '$MaskTilesPath', '$MaskMethod', $Params); exit;"

