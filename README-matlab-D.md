# he-class-pipeline

# Running the commands from ALMA
ssh ralcraft@alma.icr.ac.uk
srun --pty --mem=10GB -c 1 -t 30:00:00 -p interactive bash

# First get the code
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline
git checkout .
git pull

# conda env from Nick
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
conda deactivate
```
# run the test script 1
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d
chmod +x test_libs_outer.sh
chmod +x test_libs_inner.sh
conda activate tfAlmaGPU1p4
sbatch test_libs_outer.sh

# run the test script 2
https://uk.mathworks.com/help/matlab/matlab_external/start-the-matlab-engine-for-python.html
https://uk.mathworks.com/help/matlab/matlab_external/use-the-matlab-engine-workspace-in-python.html

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d
chmod +x test_libs_outer.sh
chmod +x test_libs_inner.sh
conda activate tfAlmaGPU1p4
sbatch test_libs_outer.sh

# just a python
conda activate tfAlmaGPU1p4
python -c "import sys; print('\n'.join(sys.path))"
python -c "import tensorflow as tf; print(tf.__version__)"

error: ImportError: libcuda.so.1: cannot open shared object file: No such file or directory
conda deactivate

# find the libcuda.so.1 and add it to path
echo $LD_LIBRARY_PATH #path

# try my own conda env
mamba create -n tf01 python=3.6
mamba activate tf01
mamba install conda-forge::tensorflow
mamba install conda-forge::tensorflow-gpu
module load cuda/10.2
python -c "import sys; print('\n'.join(sys.path))"
python -c "import tensorflow as tf; print(tf.__version__)"
python -c "import tensorflow as tf; print('Num GPUs Available'); print(len(tf.config.experimental.list_physical_devices('GPU')))"
pip install tensorflow-gpu==1.4.0













# First conda environment
mamba activate tf1p4
cd /opt/software/applications/MATLAB/R2023b/extern/engines/python/
python -m pip install .
conda deactivate

conda activate pytorch0p3
conda install -c conda-forge opencv
mamba deactivate

create conda env rom a directory with -p