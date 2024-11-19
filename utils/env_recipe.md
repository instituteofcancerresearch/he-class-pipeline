To create an environment for image comparison, run the following commands in terminal:

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

To activate the environment, run:

```console
conda activate compare-images-env
```

To deactivate the environment, run:

```console
conda deactivate
```

To save the environment specifications, run the following commands to generate environment.yml file and requirements.txt files:

```console
conda env export --from-history > environment.yaml
pip freeze > requirements.txt
```

If you want to create the same environment in the future, you can run the following commands:
 
```console
conda env create -f environment.yaml
pip install -r requirements.txt
```