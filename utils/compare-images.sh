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

image_dir_d2=$7
pipes=$8

# Fixed comparison directories
image_comp_a="${pipeline_path}/regression/outA-Tiles"
image_comp_b="${pipeline_path}/regression/outB-Masks"
image_comp_c="${pipeline_path}/regression/outC-Norm"

image_comp_d1_ai="${pipeline_path}/regression/outD1-Detection/20180117/annotated_images"
image_comp_d1_csv="${pipeline_path}/regression/outD1-Detection/20180117/csv"
image_comp_d1_h5="${pipeline_path}/regression/outD1-Detection/20180117/h5"
image_comp_d1_pp="${pipeline_path}/regression/outD1-Detection/20180117/pre_processed"

image_comp_d2="${pipeline_path}/regression/outD2-Classification"
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

echo "image_dir_d2: $image_dir_d2"

echo "image_comp_a: $image_comp_a"
echo "image_comp_b: $image_comp_b"
echo "image_comp_c: $image_comp_c"

echo "image_comp_d1-ai: $image_comp_d1_ai"
echo "image_comp_d1-csv: $image_comp_d1_csv"
echo "image_comp_d1-h5: $image_comp_d1_h5"
echo "image_comp_d1-pp: $image_comp_d1_pp"

echo "image_comp_d2: $image_comp_d2"

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
    srun python $python_script "$image_dir_d1" "$image_comp_d1_csv" "N"
    srun python $python_script "$image_dir_d1" "$image_comp_d1_h5" "N"
    srun python $python_script "$image_dir_d1" "$image_comp_d1_pp" "N"
fi

if [[ $pipes == *"D2"* ]]; then
    echo -e "Running compare images script for D2..."
    srun python $python_script "$image_dir_d2" "$image_comp_d2" "N"
fi

#echo -e "Deactivating conda enviroment..."
mamba deactivate