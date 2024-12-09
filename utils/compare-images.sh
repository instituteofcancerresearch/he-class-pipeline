#!/bin/bash

source /data/scratch/shared/RSE/sources/.rachel

pipeline_path=$1
regression_path=$2
conda_path=$3
image_dir_a=$4
image_dir_b=$5
image_dir_c=$6

image_dir_d1_ai="$7/20180117/annotated_images"
image_dir_d1_csv="$7/20180117/csv"
image_dir_d1_h5="$7/20180117/h5"
image_dir_d1_pp="$7/20180117/pre_processed"

image_dir_d2_ac="$8/all_cells"
image_dir_d2_csv="$8/csv"
image_dir_d2_li="$8/labelledImages"
image_dir_d2_big="$8/labelledImagesBigDot"
image_dir_d2_th="$8/thumbnails"
image_dir_d2_tif="$8/tif"

pipes=$9

# Fixed comparison directories
image_comp_a="${regression_path}/outA-Tiles"
image_comp_b="${regression_path}/outB-Masks"
image_comp_c="${regression_path}/outC-Norm"

image_comp_d1_ai="${regression_path}/outD1-Detection/20180117/annotated_images"        #png
image_comp_d1_csv="${regression_path}/outD1-Detection/20180117/csv"                    #csv
image_comp_d1_h5="${regression_path}/outD1-Detection/20180117/h5"                      #h5
image_comp_d1_pp="${regression_path}/outD1-Detection/20180117/pre_processed"           #h5

image_comp_d2_ac="${regression_path}/outD2-Classification/all_cells"                   #csv
image_comp_d2_csv="${regression_path}/outD2-Classification/csv"                        #csv
image_comp_d2_li="${regression_path}/outD2-Classification/labelledImages"              #jpg
image_comp_d2_big="${regression_path}/outD2-Classification/labelledImagesBigDot"       #jpg
image_comp_d2_th="${regression_path}/outD2-Classification/thumbnails"                  #png
image_comp_d2_tif="${regression_path}/outD2-Classification/tif"                        #tif


python_script="${pipeline_path}/utils/compare-images.py"

echo "*********INPUTS***********************"
echo "pipe_path: $pipeline_path"
echo "regression_path: $regression_path"
echo "conda_path: $conda_path"
echo "pipes: $pipes"
echo "python_script: $python_script"

# conda init
echo -e "Activating conda enviroment..."
# conda activate comprate-images-env
mamba activate $conda_path

if [[ $pipes == *"A"* ]]; then
    echo -e "Running compare images script for A..."
    echo "image_dir_a: $image_dir_a"
    echo "image_comp_a: $image_comp_a"
    srun python $python_script "$image_dir_a" "$image_comp_a" "N" "Y" "x"
fi

if [[ $pipes == *"B"* ]]; then
    echo -e "Running compare images script for B..."
    echo "image_dir_b: $image_dir_b"
    echo "image_comp_b: $image_comp_b"
    srun python $python_script "$image_dir_b" "$image_comp_b" "N" "Y" "x"
fi

if [[ $pipes == *"C"* ]]; then
    echo -e "Running compare images script for C..."
    echo "image_dir_c: $image_dir_c"
    echo "image_comp_c: $image_comp_c"
    srun python $python_script "$image_dir_c" "$image_comp_c" "N" "Y" "x"
fi

if [[ $pipes == *"D1"* ]]; then
    echo -e "Running compare images script for D1..."
    echo "image_dir_d1-ai: $image_dir_d1_ai"
    echo "image_dir_d1-csv: $image_dir_d1_csv"
    echo "image_dir_d1-h5: $image_dir_d1_h5"
    echo "image_dir_d1-pp: $image_dir_d1_pp"

    echo "image_comp_d1-ai: $image_comp_d1_ai"
    echo "image_comp_d1-csv: $image_comp_d1_csv"
    echo "image_comp_d1-h5: $image_comp_d1_h5"
    echo "image_comp_d1-pp: $image_comp_d1_pp"

    srun python $python_script "$image_dir_d1_ai" "$image_comp_d1_ai" "N" "Y" "x"
    srun python $python_script "$image_dir_d1_csv" "$image_comp_d1_csv" "N" "Y" "x"
    srun python $python_script "$image_dir_d1_h5" "$image_comp_d1_h5" "N" "Y" "all"
    srun python $python_script "$image_dir_d1_h5" "$image_comp_d1_h5" "N" "Y" "output"
    srun python $python_script "$image_dir_d1_h5" "$image_comp_d1_h5" "N" "Y" "feat"
    srun python $python_script "$image_dir_d1_pp" "$image_comp_d1_pp" "N" "Y" "x"
fi

if [[ $pipes == *"D2"* ]]; then
    echo -e "Running compare images script for D2..."
    
    echo "image_dir_d2-ac: $image_dir_d2_ac"
    echo "image_dir_d2-csv: $image_dir_d2_csv"
    echo "image_dir_d2-li: $image_dir_d2_li"
    echo "image_dir_d2-big: $image_dir_d2_big"
    echo "image_dir_d2-th: $image_dir_d2_th"
    echo "image_dir_d2-tif: $image_dir_d2_tif"

    echo "image_comp_d2-ac: $image_comp_d2_ac"
    echo "image_comp_d2-csv: $image_comp_d2_csv"
    echo "image_comp_d2-li: $image_comp_d2_li"
    echo "image_comp_d2-big: $image_comp_d2_big"
    echo "image_comp_d2-th: $image_comp_d2_th"
    echo "image_comp_d2-tif: $image_comp_d2_tif"

    srun python $python_script "$image_dir_d2_ac" "$image_comp_d2_ac" "N" "N" "x"
    srun python $python_script "$image_dir_d2_csv" "$image_comp_d2_csv" "N" "Y" "x"
    srun python $python_script "$image_dir_d2_li" "$image_comp_d2_li" "N" "Y" "x"
    srun python $python_script "$image_dir_d2_big" "$image_comp_d2_big" "N" "Y" "x"
    srun python $python_script "$image_dir_d2_tif" "$image_comp_d2_tif" "N" "N" "x"
fi

#echo -e "Deactivating conda enviroment..."
mamba deactivate