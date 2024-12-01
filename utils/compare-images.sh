#!/bin/bash

source /data/scratch/shared/RSE/sources/.rachel

pipeline_path=$1
conda_path=$2
image_dir_a=$3
image_dir_b=$4
image_dir_c=$5
image_dir_d1=$6
image_dir_d2=$7
pipes=$8 

# Fixed comparison directories
image_comp_a="${pipeline_path}/regression/outA-Tiles"
image_comp_b="${pipeline_path}/regression/outB-Masks"
image_comp_c="${pipeline_path}/regression/outC-Norm"
image_comp_d1="${pipeline_path}/regression/outD1-Detection"
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
echo "image_dir_d1: $image_dir_d1"
echo "image_dir_d2: $image_dir_d2"
echo "image_comp_a: $image_comp_a"
echo "image_comp_b: $image_comp_b"
echo "image_comp_c: $image_comp_c"
echo "image_comp_d1: $image_comp_d1"
echo "image_comp_d2: $image_comp_d2"

# conda init
echo -e "Activating conda enviroment..."
# conda activate comprate-images-env
mamba activate $conda_path

if [[ $steps == *"A"* ]]; then
    echo -e "Running compare images script for A..."
    srun python $python_script "$image_dir_a" "$image_comp_a" "N"
fi

if [[ $steps == *"B"* ]]; then
    echo -e "Running compare images script for B..."
    srun python $python_script "$image_dir_b" "$image_comp_b" "N"
fi

if [[ $steps == *"C"* ]]; then
    echo -e "Running compare images script for C..."
    srun python $python_script "$image_dir_c" "$image_comp_c" "N"
fi

if [[ $steps == *"D1"* ]]; then
    echo -e "Running compare images script for D1..."
    srun python $python_script "$image_dir_d1" "$image_comp_d1" "N"
fi

if [[ $steps == *"D2"* ]]; then
    echo -e "Running compare images script for D2..."
    srun python $python_script "$image_dir_d2" "$image_comp_d2" "N"
fi

echo -e "Deactivating conda enviroment..."
mamba deactivate