# Getting a matlab with python working as a standalone along with tensorflow

# Tensorflow versions
https://stackoverflow.com/questions/50622525/which-tensorflow-and-cuda-version-combinations-are-compatible

# First conda environment
mamba create -n py10-ml python=3.10
mamba activate py10-ml
mamba install conda-forge::cudatoolkit=11.2.2
mamba install conda-forge::cudnn=8.1.0.77
#mamba install conda-forge::tensorflow
pip install --upgrade pip
pip install tensorflow-gpu==2.10.0

mamba create -n py6-ml python=3.6.2
mamba activate py6-ml
mamba install conda-forge::cudatoolkit=8
mamba install conda-forge::cudnn=6
pip install --upgrade pip
pip install tensorflow-gpu==1.4.0


# Check python version
python --version
python -c "import sys; print('\n'.join(sys.path))"

# Check tensorflow version and GPUs
python -c "import tensorflow as tf; print(tf.__version__)"
python -c "import tensorflow as tf; print('Num GPUs Available'); print(len(tf.config.experimental.list_physical_devices('GPU')))"



