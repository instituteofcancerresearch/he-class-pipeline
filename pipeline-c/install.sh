#!/bin/sh
#SBATCH -J "HECi"
#SBATCH -o c_install.out
#SBATCH -e c_install.err
#SBATCH -n 4
#SBATCH -t 100:00:00
source ~/.bashrc
singularity_path=$1
branch=$2
echo "Singularity path: $singularity_path"
echo "Branch: $branch"
# concat file path with file
singularity_path="$singularity_path/HEC.sif"
docker_path="docker://icrsc/he-class-norm"
singularity build --force $singularity_path $docker_path
# if in the right place:
#/data/scratch/shared/SINGULARITY-DOWNLOAD/tools/.singularity
#singularity build --force HEC.sif docker://icrsc/he-class-norm