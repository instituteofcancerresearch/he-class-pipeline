# he-class-pipeline

# Running the commands from ALMA
ssh ralcraft@alma.icr.ac.uk
srun --pty --mem=10GB -c 1 -t 30:00:00 -p interactive bash

# First try to run the script directly
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline
git checkout .
git pull
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d

mamba works conda doesn't
mamba remove --name tf1p4 --all
mamba env create -f conda_ymls/tf1p4.yml

conda remove --name pytorch0p3 --all
conda env create -f conda_ymls/pytorch0p3.yml

chmod +x run_cell_classifier.sh
./run_cell_classifier.sh

# First conda environment
mamba activate tf1p4
cd /opt/software/applications/MATLAB/R2023b/extern/engines/python/
python -m pip install .
conda deactivate

conda activate pytorch0p3
conda install -c conda-forge opencv
mamba deactivate

# run the script 1
cd code/cell_detector/analysis
mamba activate tf-gpu1
python3 ./Generate_Output.py cellDetectorCheckPointPath tilePath cellDetectionResultsPath detectionBatchSize imageName segmentationTilePath


/opt/software/applications/MATLAB/R2023b/extern/engines/python

cd "/mnt/c/Program Files/MATLAB/R2023a/extern/engines/python"

c from linux: 

# conda env from Nick
create conda env rom a directory with -p
```
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/conda-envs
tar -xvjf tfAlmaGPU1p4.tar.bz2
conda env create -p /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/conda_envs/tf1p4 -f conda_ymls/tf1p4.yml
# i keep my conda in  /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/.conda_simlink/envs
cp -r /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/conda-envs/.conda/envs/tfAlmaGPU1p4 /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/.conda_simlink/envs
# find the conda envs
conda info --envs
# you should now see tfAlmaGPU1p4
conda activate tfAlmaGPU1p4

```








