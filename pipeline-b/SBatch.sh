#!/bin/sh

#SBATCH -J "HEBr"
#SBATCH -o b_run.out
#SBATCH -e b_run.err
#SBATCH -n 4
#SBATCH -t 100:00:00

source ~/.bashrc
module load MATLAB/R2020b

pipeline_path=$1
input_path=$2
output_path=$3
method=$4

echo "Pipeline path: $pipeline_path"
echo "Input: $input_path"
echo "Output: $output_path"

# concat file path with file

matlab -nodesktop -nosplash -r "addpath(genpath('$pipeline_path/pipeline-b/')); CreateMaskTilesBatch('$input_path', '$output_path', '""'); exit;"

