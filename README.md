# he-class-pipeline

# Running the commands from ALMA
ssh ralcraft@alma.icr.ac.uk
srun --pty --mem=10GB -c 1 -t 30:00:00 -p interactive bash

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier

module load MATLAB/R2020b

ImageTilesPath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA/"
MaskTilesPath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB/"
MaskMethod="E";
Params="'jpg', [3.5 500 225]"
varargin = "1"
codePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/code/"
module load MATLAB

matlab -nodesktop -nosplash -r "addpath(genpath('${codePath}')); CreateMaskTilesBatch('$ImageTilesPath', '$MaskTilesPath', '$MaskMethod', $varargin); exit;"

matlab -nodesktop -nosplash -r "addpath(genpath('./code/')); CreateMaskTilesBatch('/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA/', '/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB/', '"E"', '"1"'); exit;"

matlab -nodesktop -nosplash -r "addpath(genpath('./code/')); CreateMaskTilesBatch('/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA/', '/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB/', '"E"'); exit;"







