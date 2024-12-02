#!/bin/sh

#SBATCH -J "MaskTiles"
#SBATCH -o /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/MaskTiles.output.%j
#SBATCH -e /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/MaskTiles.errors.%j
#SBATCH -n 4
#SBATCH --mail-type="END,FAIL"
#SBATCH -t 100:00:00
#SBATCH --mail-user="nick.trahearn@icr.ac.uk"

# RSA: This file lives in Nick Trahearn's scratch at: 
# /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/slurm/MaskTiles.sh

module load MATLAB/R2020b

ImageTilesPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/test1/Tiles/"
MaskTilesPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/test1/Masks1/"

#MaskMethod="T";
#Params="'jpg', [0, 210]"

MaskMethod="E";
#Params="'jpg', [3.5 500 225]"
Params="'jpg', [3.5 5000 225]"

codePath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Code/MaskTiles/"

module load MATLAB

matlab -nodesktop -nosplash -r "addpath(genpath('${codePath}')); CreateMaskTilesBatch('$ImageTilesPath', '$MaskTilesPath', '$MaskMethod', $Params); exit;"
