################### BUILD AND RUN THIS DOCKER FILE ############################
# https://guiesbibtic.upf.edu/recerca/hpc/running-singularity-containers-with-gpu

### BUILD IMAGE FROM root directory of project
# docker build -t icrsc/he-class-alma -f pipeline-b/Dockerfile pipeline-b/

### TEST IMAGE
#singularity run --nv docker://icrsc/he-class-alma python -c "import tensorflow as tf; print('Num GPUs Available: ',len(tf.config.experimental.list_physical_devices('GPU'))); print('Tensorflow version: ',tf.__version__)"

### PUSH IMAGE TO DOCKER HUB
# docker push icrsc/he-class-alma
#################################################################################

FROM tensorflow/tensorflow:2.16.1-gpu as base
