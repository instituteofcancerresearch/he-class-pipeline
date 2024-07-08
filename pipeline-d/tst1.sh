#!/bin/bash
#SBATCH -J tensorflow_sim
#SBATCH -N 1
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu
#SBATCH -o slurm.out # STDOUT
#SBATCH -e slurm.err # STDERR

module load cuda/11.1

# The folders are controlled by the user
log_output="$1"
echo "Log output: $log_output"
data_input="$2"
echo "Data input: $data_input"
sing_im="$3/he-class-alma.sif"
echo "Singularity image: $sing_im"

echo "Pulling the singularity image with the following command: singularity pull $sing_im docker://icrsc/he-class-alma"
singularity pull "$sing_im" docker://icrsc/he-class-alma

echo "Running the singularity container with the following command: singularity run --nv --bind $log_output:/heapplog/ $sing_im python tst1.py /heapplog/ $data_input"
singularity run --nv --bind "$log_output":/heapplog/ "$sing_im" python ./he-class-pipeline/pipeline-b/tst1.py /heapplog/ "$data_input"




