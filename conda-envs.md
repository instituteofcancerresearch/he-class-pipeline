ssh ralcraft@alma.icr.ac.uk
srun --pty --mem=4GB -c 1 -t 30:00:00 -p interactive bash

/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/slurm

# There are a set of old and new conda environments that need to be used for comparison

Pipeline A OLD:
/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/
module load anaconda/3 java/jdk15.0.1		    
source activate openslide-mod

Pipeline A NEW:
/data/scratch/shared/SINGULARITY-DOWNLOAD/mamba/
echo "conda_dir: $conda_dir"
conda_env1="$conda_dir/he-shared-tensorflow"

To load the old one, run the following:
mamba activate /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/rse-openslide-mod
cd /data/scratch/shared/RSE/mamba
conda env export > openslide-mod.yml
conda env export --from-history > rse-openslide-mod-min.yml
mamba deactivate

To load from these files

mamba env update -n rse-openslide-mod --file /data/scratch/shared/RSE/mamba/rse-openslide-mod.yml
mamba env delete -n rse-openslide-mod
mamba env create -f /data/scratch/shared/RSE/mamba/rse-openslide-mod.yml
mamba env create -f /data/scratch/shared/RSE/mamba/rse-openslide-mod-min.yml



