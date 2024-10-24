
#### Go to the working directory
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old

#### The slurm script I use for pipeline A is located here:
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/OSTiles-rse.sh
or
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/OSTiles.sh (no params)

sbatch /data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/OSTiles.sh
squeue -u $USER

or 
```
CodePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/Code/OSTiles/"
ImageDir="/data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs/"
TilePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/out/"
sbatch /data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/old-pipeline-a/OSTiles.sh $CodePath $ImageDir $TilePath
squeue -u $USER
```
