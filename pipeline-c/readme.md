# Pipeline C: Normalisation

python3 -m venv .venv-c
source .venv-c/bin/activate
pip install --upgrade pip
pip install tifffile
#RUN pip install javabridge
#RUN pip install openslide-python
#pip install python-bioformats
pip install certifi
pip install future
pip install imagecodecs
pip install imagecodecs-lite
pip install numpy
pip install Pillow
pip install scipy
pip install opencv-contrib-python

run this locally
```bash
#cws_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Tiles_temp'
#target_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Forecast/Final/Tiles_Norm/IM1012S4.czi'
#out_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Norm2_temp'
#cws_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Masks'

#norm_cws_by_stats_batch('${cws_path}', '${target_path}', '${out_path}', '${cws_mask_path}', '${target_mask_path}', file_pattern='*.*')"

/home/ralcraft/dev/shiny-proxy-developed/he-class-app/pipelines/in-a

python code/calling_wrapper.py "/home/ralcraft/dev/shiny-proxy-developed/he-class-app/pipelines/out-a" "/home/ralcraft/dev/shiny-proxy-developed/he-class-app/pipelines/out-c/c.czi" "/home/ralcraft/dev/shiny-proxy-developed/he-class-app/pipelines/out-c" "" "" "*.*"

singularity run -B /home/ralcraft/dev/shiny-proxy-developed/he-class-app/pipelines/out-a:/input -B /home/ralcraft/dev/shiny-proxy-developed/he-class-app/pipelines/out-c:/output docker://icrsc/he-class-norm /input /output/c.czi /output "" "" "*.*"
```