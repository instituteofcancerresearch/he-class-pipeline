# https://biohpc.cornell.edu/doc/CondaInContainer.html
# https://github.com/instituteofcancerresearch/SOPRANO/blob/python/Dockerfile

################### BUILD AND RUN THIS DOCKER FILE ############################
# cd into the pipeline-a directory

### BUILD IMAGE FROM root directory of project
# docker build -t icrsc/he-class-slide .

### TEST IMAGE
#singularity run --nv docker://icrsc/he-class-slide python -c "print('Hello World')"

### PUSH IMAGE TO DOCKER HUB
# docker push icrsc/he-class-slide
#################################################################################

FROM condaforge/mambaforge:23.3.1-1 as conda

# Construct conda environment and clean up cache files
COPY env/OSEnv.yml ./

RUN mamba env create -f OSEnv.yml --name he-slide
RUN mamba clean -afy

#if you need to run pip install in the same environment, uncomment the following lines

#ARG MAMBA_DOCKERFILE_ACTIVATE=1

#RUN pip install --no-cache myPythonPackage