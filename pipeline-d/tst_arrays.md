# Running the commands from ALMA
ssh ralcraft@alma.icr.ac.uk
srun --pty --mem=10GB -c 1 -t 30:00:00 -p interactive bash

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d

chmod +x rse_sbatch_single.sh
chmod +x rse_wrap.sh

mamba list

# MAMBA ENV FOR STAGE 1 inc tensorflow and matlab #####################################
1. Install TensorFlow
mamba create -n he-tensorflow -c conda-forge python=3.7 cudatoolkit=11.2.2 cudnn=8.1.0.77
mamba activate he-tensorflow
mamba install conda-forge::tensorflow
mamba install conda-forge::tensorflow-gpu
2. Install MatLab
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/software/applications/MATLAB/R2020b/bin/glnxa64
python3 -m pip install --upgrade pip
python3 -m pip install matlabengine==9.9.6

####################################################################################################

# MAMBA ENV FOR STAGE 2 pytorch and fastai #####################################
3. Install pytorch env in python 3.6 due to very old fastai version
mamba create -n he-pytorch -c conda-forge python=3.6
  
mamba create -n he-pytorch -c conda-forge python=3.6 cudatoolkit=11.2.2 cudnn=8.1.0.77
mamba activate he-pytorch
python3 -m pip install --upgrade pip
python3 -m pip install torch==0.3.1 -f https://download.pytorch.org/whl/torch_stable.html
python3 -m pip install torchvision==0.2.1
python3 -m pip install torchtext==0.2.3
python3 -m pip install opencv-python==4.0.0.21
mamba install bcolz
python3 -m pip install fastai==0.7.0

#python3 -m pip install -e /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/code/cell_classifier/3rdparty/FastAI/
#python3 -m pip install https://download.pytorch.org/whl/cpu/torch-0.3.1-cp36-cp36m-linux_x86_64.whl

#check it works
python3 -c "import fastai;"
python3 -c "from fastai.transforms import *;"
python3 -c "import torch;print(torch.cuda.is_available())"


#############################################################
./rse_wrap.sh "/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC" "/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/code" "steps1"

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev

sbatch --error=logsD/tst.err --output=logsD/tst.out --job-name=tst \
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d/rse_sbatch_single.sh \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA/SS-05-14545-1A.ndpi \
SS-05-14545-1A.ndpi \
/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d \
steps23 \
/data/scratch/shared/SINGULARITY-DOWNLOAD/mamba \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outB \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outD1 \
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outD2


###### SHARED MAMBA ENV FOR STAGE 3 inc tensorflow and matlab #####################################
mamba activate /data/scratch/shared/SINGULARITY-DOWNLOAD/mamba/he-shared-tensorflow
mamba activate /data/scratch/shared/SINGULARITY-DOWNLOAD/mamba/he-shared-pytorch


import sys; 

python3 -m pip uninstall torch
python3 -m pip cache purge
pip install torch -f https://download.pytorch.org/whl/torch_stable.html
pip install torch==0.3.1 -f https://download.pytorch.org/whl/torch_stable.html


sys.path.append('/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/code/cell_classifier/classification/'); import processCSVs;


processCSVs.processCSVs('/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC/SS-05-14545-1A.ndpi', '/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD/20180117/csv/', '/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA''/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellClassification/EPICC/NDPI/Current/EPICC_Cell_Classifier_NDPI.h5', '/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outE/csv/', segmentPath='/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB', batchSize='50', outLabels='['epithelial', 'stromal', 'immune', 'immune', 'unknown']',minProb='0.0', noClassLabel='4', outputProbs='False');


DetectionPath = /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD/20180117/csv/
ImagePath = /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC/SS-05-14545-1A.ndpi
GlobPath = /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC/SS-05-14545-1A.ndpi/*.csv
complete

      