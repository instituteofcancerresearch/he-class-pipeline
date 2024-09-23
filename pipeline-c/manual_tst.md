# Running the commands from ALMA
ssh xxx@alma.icr.ac.uk
srun --pty --mem=10GB -c 1 -t 30:00:00 -p interactive bash

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev


srun singularity run -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA:/input_tiles -B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/NormTiles/C4L/Tiles:/target_tiles -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outC:/output -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev:/log -B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outB:/input_masks -B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/NormTiles/C4L/Masks:/target_masks /data/scratch/shared/SINGULARITY-DOWNLOAD/tools/.singularity/HEC.sif /log /input_tiles /target_tiles /output /input_masks /target_masks "*.*"