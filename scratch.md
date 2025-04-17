############ D SCRIPT 1 ###########
source activate /data/rds/DIT/SCICOM/SCRSE/shared/conda/tfAlmaGPU1p4    
echo "Python version: $(python --version)"
#######################
bash /data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d/old_sbatch_single.sh \
/home/ralcraft/he_output/outA/SS-05-14545-1A.ndpi \
SS-05-14545-1A.ndpi \
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d \
steps1 \
/data/rds/DIT/SCICOM/SCRSE/shared/conda/tfAlmaGPU1p4 \
/data/rds/DIT/SCICOM/SCRSE/shared/conda/pytorch0p3 \
/home/ralcraft/he_output/outA \
/home/ralcraft/he_output/outB \
/home/ralcraft/he_output/outD1 \
/home/ralcraft/he_output/outD2
#######################
bash /data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/scratch.sh

############ D SCRIPT 2 ###########
source activate /data/rds/DIT/SCICOM/SCRSE/shared/conda/pytorch0p3
echo "Python version: $(python --version)"
echo "Python path: $(which python)"
python -c "import fastai"

python3 -m pip install fastai==0.7.0

source activate /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/pytorch0p3
source activate /data/scratch/shared/SINGULARITY-DOWNLOAD/mamba/he-shared-pytorch
