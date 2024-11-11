To create an environment for image comparison, run the following commands in terminal:

```console
conda create comprate-images-env
conda install conda-forge::pillow==11.0.0
conda install numpy==1.26.4
conda install pip
pip install opencv-python==4.10.0.84
pip install image-similarity-measures==0.3.6
pip install pyfftw==0.15.0
```

To run the environment, run:

```console
conda activate comprate-images-env
```

To deactivate the environment, run:

```console
conda deactivate
```

To save the environment specifications, run the following commands to generate environment.yml file and requirements.txt files:

```console
conda env export > environment.yml
pip freeze > requirements.txt
```

If you want to create the same environment in the future, you can run the following commands:
 
```console
conda create --name ENV_NAME --f environment.yml
pip install -r requirements.txt
```