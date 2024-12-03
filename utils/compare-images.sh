#!/bin/bash

source /data/scratch/shared/RSE/sources/.rachel

pipeline_path=$1
conda_path=$2
image_dir_a=$3
image_dir_b=$4
image_dir_c=$5

image_dir_d1_ai="$6/20180117/annotated_images"
image_dir_d1_csv="$6/20180117/csv"
image_dir_d1_h5="$6/20180117/h5"
image_dir_d1_pp="$6/20180117/pre_processed"

image_dir_d2_ac="$7/all_cells"
image_dir_d2_csv="$7/csv"
image_dir_d2_li="$7/labelledImages"
image_dir_d2_big="$7/labelledImagesBigDot"
image_dir_d2_th="$7/thumbnails"
image_dir_d2_tif="$7/tif"

pipes=$8

# Fixed comparison directories
image_comp_a="${pipeline_path}/regression/outA-Tiles"
image_comp_b="${pipeline_path}/regression/outB-Masks"
image_comp_c="${pipeline_path}/regression/outC-Norm"

image_comp_d1_ai="${pipeline_path}/regression/outD1-Detection/20180117/annotated_images"        #png
image_comp_d1_csv="${pipeline_path}/regression/outD1-Detection/20180117/csv"                    #csv
image_comp_d1_h5="${pipeline_path}/regression/outD1-Detection/20180117/h5"                      #h5
image_comp_d1_pp="${pipeline_path}/regression/outD1-Detection/20180117/pre_processed"           #h5

image_comp_d2_ac="${pipeline_path}/regression/outD2-Classification/all_cells"                   #csv
image_comp_d2_csv="${pipeline_path}/regression/outD2-Classification/csv"                        #csv
image_comp_d2_li="${pipeline_path}/regression/outD2-Classification/labelledImages"              #jpg
image_comp_d2_big="${pipeline_path}/regression/outD2-Classification/labelledImagesBigDot"       #jpg
image_comp_d2_th="${pipeline_path}/regression/outD2-Classification/thumbnails"                  #png
image_comp_d2_tif="${pipeline_path}/regression/outD2-Classification/tif"                        #tif


python_script="${pipeline_path}/utils/compare-images.py"

echo "*********INPUTS***********************"
echo "pipe_path: $pipeline_path"
echo "conda_path: $conda_path"
echo "pipes: $pipes"
echo "python_script: $python_script"
echo "image_dir_a: $image_dir_a"
echo "image_dir_b: $image_dir_b"
echo "image_dir_c: $image_dir_c"

echo "image_dir_d1-ai: $image_dir_d1_ai"
echo "image_dir_d1-csv: $image_dir_d1_csv"
echo "image_dir_d1-h5: $image_dir_d1_h5"
echo "image_dir_d1-pp: $image_dir_d1_pp"

echo "image_dir_d2-ac: $image_dir_d2_ac"
echo "image_dir_d2-csv: $image_dir_d2_csv"
echo "image_dir_d2-li: $image_dir_d2_li"
echo "image_dir_d2-big: $image_dir_d2_big"
echo "image_dir_d2-th: $image_dir_d2_th"
echo "image_dir_d2-tif: $image_dir_d2_tif"

echo "image_comp_a: $image_comp_a"
echo "image_comp_b: $image_comp_b"
echo "image_comp_c: $image_comp_c"

echo "image_comp_d1-ai: $image_comp_d1_ai"
echo "image_comp_d1-csv: $image_comp_d1_csv"
echo "image_comp_d1-h5: $image_comp_d1_h5"
echo "image_comp_d1-pp: $image_comp_d1_pp"

echo "image_comp_d2-ac: $image_comp_d2_ac"
echo "image_comp_d2-csv: $image_comp_d2_csv"
echo "image_comp_d2-li: $image_comp_d2_li"
echo "image_comp_d2-big: $image_comp_d2_big"
echo "image_comp_d2-th: $image_comp_d2_th"
echo "image_comp_d2-tif: $image_comp_d2_tif"

# conda init
echo -e "Activating conda enviroment..."
# conda activate comprate-images-env
mamba activate $conda_path

if [[ $pipes == *"A"* ]]; then
    echo -e "Running compare images script for A..."
    srun python $python_script "$image_dir_a" "$image_comp_a" "N"
fi

if [[ $pipes == *"B"* ]]; then
    echo -e "Running compare images script for B..."
    srun python $python_script "$image_dir_b" "$image_comp_b" "N"
fi

if [[ $pipes == *"C"* ]]; then
    echo -e "Running compare images script for C..."
    srun python $python_script "$image_dir_c" "$image_comp_c" "N"
fi

if [[ $pipes == *"D1"* ]]; then
    echo -e "Running compare images script for D1..."
    srun python $python_script "$image_dir_d1" "$image_comp_d1_ai" "N"
    #srun python $python_script "$image_dir_d1" "$image_comp_d1_csv" "N"
    #srun python $python_script "$image_dir_d1" "$image_comp_d1_h5" "N"
    #srun python $python_script "$image_dir_d1" "$image_comp_d1_pp" "N"
fi

if [[ $pipes == *"D2"* ]]; then
    echo -e "Running compare images script for D2..."
    srun python $python_script "$image_dir_d2_li" "$image_comp_d2_li" "N"
    srun python $python_script "$image_dir_d2_big" "$image_comp_d2_big" "N"
fi

#echo -e "Deactivating conda enviroment..."
mamba deactivate