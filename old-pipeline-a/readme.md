ssh ralcraft@alma.icr.ac.uk
srun --pty -t 12:00:00 -p interactive bash

mkdir -p /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old

The slurm script I use for pipeline A is located here:
/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/slurm/OSTiles.sh
And I just run it with no additional arguments, so just "slurm OSTiles.sh".

I copied it to: 
/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/OSTiles-ra.sh

And changd appropriate output logs and paths to the pipeline code.

sbatch OSTiles-ra.sh
squeue -u $USER

recreate the env from the yml file
conda remove --name openslide-mod --all
module load java/jdk15.0.1
conda env create -f OSTiles.yml (or if you want to change the name, conda env create -n open-mod -f OSTiles.yml)

But it doesn;t seem to work so I have copied Nick's full openslide-mod folder from his 
/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/openslide-mod
to mine

... try again ...
sbatch OSTiles-ra.sh
squeue -u $USER


# copy conda env to RSE shared
cp -r /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/.conda_simlink/envs/openslide-mod 
mv -r /data/scratch/shared/RSE/.conda/openslide-mod /data/scratch/shared/RSE/.conda/envs/openslide-mod
