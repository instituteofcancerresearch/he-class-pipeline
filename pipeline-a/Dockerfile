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
COPY mamba/OSEnv.yml ./

RUN mamba env create -f OSEnv.yml
RUN mamba clean -afy

#if you need to run pip install in the same environment, uncomment the following lines
ARG MAMBA_DOCKERFILE_ACTIVATE=1

RUN pip install --no-cache-dir --upgrade pip

#RUN pip install javabridge
#RUN pip install --no-cache-dir numpy
#RUN pip install --no-cache-dir openslide-python
#RUN pip install --no-cache Pillow==6.1.0
#RUN pip install --no-cache python-bioformats==1.3.0
#RUN pip install --no-cache scipy==0.19.1
#RUN pip install --no-cache tifffile==2019.7.26.2
#- javabridge==1.0.19
#- tifffile==2019.7.26.2
#- openslide-python==1.1.1
#- python-bioformats==1.3.0