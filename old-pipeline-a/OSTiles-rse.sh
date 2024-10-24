#!/bin/bash

#SBATCH -J "OS-ra-Tiles"
#SBATCH -o /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/logs/OSTiles.%j.out
#SBATCH -e /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/logs/OSTiles.%j.err
#SBATCH -n 8
#SBATCH --mail-type="END,FAIL"
#SBATCH -t 100:00:00
#is_singularity="TRUE"

CodePath=$1
ImageDir=$2
TilePath=$3

if [[ "$is_singularity" == "TRUE" ]]; then    
	exho "Running the script in the singularity container..."
    #ImageDir="/data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs/"
    #TilePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/out/"
    ImageFileExtension="ndpi"
    InMPP=None
    OutMPP=0.22098959139024552
    OutMPP=None
    #CodePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/Code/OSTiles/"
    #module load anaconda/3 openslide java/jdk15.0.1
	module load anaconda/3 java/jdk15.0.1		    
	source /data/scratch/shared/RSE/sources/.nick
    #source /data/scratch/shared/RSE/sources/.rachel
    source activate /data/scratch/shared/RSE/.conda/envs/openslide-mod
    #source activate openslide-mod	
    mkdir -p "$TilePath"

    for ImagePath in "$ImageDir"/*."$ImageFileExtension"; do
        echo "Processing $ImagePath"
        ImageFileName=$(basename "$ImagePath")
        python3 "$CodePath/generate_cws.py" "$ImagePath" $OutMPP $InMPP "$TilePath"
    done
else    
	echo "Setting up the singularity container..."
    export SINGULARITYENV_is_singularity="TRUE"
    OpenSlideContainerPath="/opt/software/containers/singularity/openslideicr.sif"
    singularity exec --bind "/opt/software,/data," "$OpenSlideContainerPath" "$0"    
fi
