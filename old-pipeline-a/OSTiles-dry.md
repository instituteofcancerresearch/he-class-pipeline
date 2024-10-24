
ssh ralcraft@alma.icr.ac.uk
srun --pty -t 12:00:00 -p interactive bash

#### Go to the working directory
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old

#### The slurm script I use for pipeline A is located here:
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/OSTiles-rse.sh
```
CodePath="/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/Code/OSTiles/"
ImageDir="/data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs/"
TilePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/out/"
sbatch /data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/OSTiles-rse.sh $CodePath $ImageDir $TilePath
squeue -u $USER
```
