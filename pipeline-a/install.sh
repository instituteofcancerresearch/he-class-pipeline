#!/bin/sh
#SBATCH -J "HEBi"
#SBATCH -o a_install.out
#SBATCH -e a_install.err
#SBATCH -n 4
#SBATCH -t 100:00:00
source ~/.bashrc
singularity_path=$1
branch=$2
echo "Singularity path: $singularity_path"
echo "Branch: $branch"
# concat file path with file
singularity_path="$singularity_path/HEA.sif"
docker_path="docker://icrsc/he-class-slide"
singularity build --force $singularity_path $docker_path