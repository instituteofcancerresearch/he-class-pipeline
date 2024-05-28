#!/bin/bash
#SBATCH -J tensorflow_sim
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu
#SBATCH --chdir=/home/ralcraft/he-class/he-class-pipeline/pipeline-b/
#SBATCH -o slurm.out # STDOUT
#SBATCH -e slurm.err # STDERR

module load cuda/11.1

##singularity run --nv /soft/singularity/tensorflow_20.08-tf2-py3.sif python -c "import tensorflow as tf; print('Num GPUs Available: ',len(tf.config.experimental.list_physical_devices('GPU'))); print('Tensorflow version: ',tf.__version__)"

#singularity run --nv docker://tensorflow/tensorflow:latest-gpu python -c "import tensorflow as tf; print('Num GPUs Available: ',len(tf.config.experimental.list_physical_devices('GPU'))); print('Tensorflow version: ',tf.__version__)"

singularity run --nv --bind .:/data/ docker://icrsc/he-class-alma python tst1.py




