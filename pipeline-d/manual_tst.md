# Running the commands from ALMA
ssh xxx@alma.icr.ac.uk
srun --pty --mem=10GB -c 1 -t 30:00:00 -p interactive bash

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev

Running the wraper
#############################################################
./rse_wrap.sh "/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC" "/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/code" "steps1"

Running a single process
###################################################################
sbatch --error=logsD/tst.err --output=logsD/tst.out --job-name=tst \
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d/rse_sbatch_single.sh \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA/SS-05-14545-1A.ndpi \
SS-05-14545-1A.ndpi \
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d \
steps123 \
/data/scratch/shared/SINGULARITY-DOWNLOAD/mamba \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outB \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outD1 \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outD2


###### SHARED MAMBA ENV FOR STAGE 3 inc tensorflow and matlab #####################################
mamba activate /data/scratch/shared/SINGULARITY-DOWNLOAD/mamba/he-shared-tensorflow
mamba activate /data/scratch/shared/SINGULARITY-DOWNLOAD/mamba/he-shared-pytorch
