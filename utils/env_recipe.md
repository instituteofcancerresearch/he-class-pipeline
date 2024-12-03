# Setting up an environment 
If you are setting up a conda or mamba environment on the Alma cluster, make sure you first ask for an interactive shell...

```console
srun --pty -t 10:00:00 -p interactive bash
```

# Conda environment
To create an environment on our local machine for image comparison, run the following commands in terminal:

```console
conda create --name compare-images-env
conda activate compare-images-env
conda install -c conda-forge pillow
conda install numpy
pip install opencv-python
pip install pyfftw
pip install scikit-image
pip install image-similarity-measures
```

# Mamba environment
To create an environment on mamba cluster, run...

```console
mamba create --name compare-images-env -c conda-forge python=3.10 numpy pillow pyfftw
mamba activate compare-images-env
pip install opencv-python
pip install image-similarity-measures
conda deactivate 
```

# General instructions
To activate the conda environment, run:

```console
conda activate compare-images-env
```

To activate the mamba environment, run:

```console
mamba activate compare-images-env
```

To deactivate the conda environment, run:

```console
conda deactivate
```

To deactivate the mamba environment, run:

```console
mamba deactivate
```

To save the environment specifications, run the following commands to generate environment.yaml file and requirements.txt files:

```console
conda env export --from-history > conda_environment.yaml # or mamba env export --from-history > mamba_environment.yaml
pip freeze > requirements.txt
```

Paste the pip packages under conda/mamba dependencies. 

If you want to create the same environment in the future, you can run the following commands:
 
```console
conda env create -f conda_environment.yaml # or mamba env create -f mamba_environment.yaml
```

# Creating this in the shared RSE directory
```
cd /data/scratch/shared/RSE/envs
mamba create --prefix /data/scratch/shared/RSE/envs/he-compare-images -c conda-forge python=3.10 numpy pillow pyfftw
mamba activate he-compare-images
python -m pip install opencv-python
python -m pip install image-similarity-measures
mamba deactivate
```