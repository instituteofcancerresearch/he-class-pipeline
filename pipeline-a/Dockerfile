################### BUILD AND RUN THIS DOCKER FILE ############################
# cd into the pipeline-a directory

### BUILD IMAGE FROM root directory of project
# docker build -t icrsc/he-class-slide .

### TEST IMAGE
#singularity run --nv docker://icrsc/he-class-slide python -c "print('Hello World')"

### PUSH IMAGE TO DOCKER HUB
# docker push icrsc/he-class-slide
#################################################################################

FROM python:3.8

RUN mkdir /app
WORKDIR /app

# install JAVA
ENV JAVA_HOME=/app/jdk-20.0.2
ENV PATH=$JAVA_HOME/bin:$PATH
RUN wget -O jdk.tar.gz https://download.oracle.com/java/20/archive/jdk-20.0.2_linux-x64_bin.tar.gz
RUN tar zxvf jdk.tar.gz


RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir tifffile
RUN pip install --no-cache-dir javabridge
RUN pip install --no-cache-dir openslide-python
RUN pip install --no-cache-dir python-bioformats
RUN pip install --no-cache-dir certifi
RUN pip install --no-cache-dir future
RUN pip install --no-cache-dir imagecodecs
RUN pip install --no-cache-dir imagecodecs-lite
RUN pip install --no-cache-dir numpy
RUN pip install --no-cache-dir Pillow
RUN pip install --no-cache-dir scipy

COPY ./code /app/code

ENTRYPOINT [ "python3","/app/code/main.py"]