#!/bin/sh
#SBATCH -J "HEDi"
#SBATCH -o d_install.out
#SBATCH -e d_install.err
#SBATCH -n 1
#SBATCH -t 10:00:00

conda_dir=$1

source ~/.bashrc

# MAMBA ENV FOR STAGE 1 inc tensorflow and matlab #####################################
#1. Install TensorFlow
echo "conda_dir: $conda_dir"
conda_env1="$conda_dir/he-shared-tensorflow"
echo "conda_env1: $conda_env2"
echo "Creating conda env for tensorflow"
mamba create --force --prefix "$conda_env1" -c conda-forge python=3.7 cudatoolkit=11.2.2 cudnn=8.1.0.77
mamba activate $conda_env1
mamba install --force conda-forge::tensorflow
mamba install --force conda-forge::tensorflow-gpu
mamba install --force pillow
#2. Install MatLab
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/software/applications/MATLAB/R2020b/bin/glnxa64
python3 -m pip install --upgrade pip
python3 -m pip install matlabengine==9.9.6
mamba install --force -c conda-forge cudatoolkit-dev
mamba deactivate
echo "Finished installing tensorflow"
####################################################################################################

# MAMBA ENV FOR STAGE 2 pytorch and fastai #####################################
#3. Install pytorch env in python 3.6 due to very old fastai version 
echo "Creating conda env for pytorch"
conda_env2="$conda_dir/he-shared-pytorch"
echo "conda_env2: $conda_env2"
mamba create --force --prefix "$conda_env2" -c conda-forge python=3.6 cudatoolkit=11.2.2 cudnn=8.1.0.77
mamba activate $conda_env2
python3 -m pip install --upgrade pip
python3 -m pip install torch==0.3.1 -f https://download.pytorch.org/whl/torch_stable.html
python3 -m pip install torchvision==0.2.1
python3 -m pip install torchtext==0.2.3
python3 -m pip install opencv-python==4.0.0.21
mamba install --force bcolz
python3 -m pip install fastai==0.7.0
mamba install --force -c conda-forge cudatoolkit-dev
mamba deactivate
echo "Finished installing pytorch"

echo "Complete"
