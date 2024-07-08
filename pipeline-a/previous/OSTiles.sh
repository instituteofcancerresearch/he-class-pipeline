#!/bin/sh
 
#SBATCH -J "OSTiles"
#SBATCH -o /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/OSTiles.output.%j
#SBATCH -e /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/OSTiles.errors.%j
#SBATCH -n 8
#SBATCH --mail-type="END,FAIL"
#SBATCH -t 100:00:00
#SBATCH --mail-user="nick.trahearn@icr.ac.uk"
#is_singularity="TRUE"

if [[ "$is_singularity" == "TRUE" ]]; then
    ImageDir="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/tmp/test/"
    TilePath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/test/"
    ImageFileExtension="ndpi"

    InMPP=None
    OutMPP=0.22098959139024552

    CodePath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Code/OSTiles/"

    module load anaconda/3 openslide java/jdk15.0.1
    source activate openslide-mod

    mkdir -p "$TilePath"

    for ImagePath in "$ImageDir"/*."$ImageFileExtension"; do
        ImageFileName=$(basename "$ImagePath")

        python3 "$CodePath/generate_cws.py" "$ImagePath" $OutMPP $InMPP "$TilePath"
    done
else
    export SINGULARITYENV_is_singularity="TRUE"
    OpenSlideContainerPath="/opt/software/containers/singularity/openslideicr.sif"
    singularity exec --bind "/opt/software,/data," "$OpenSlideContainerPath" "$0"
    #singularity exec -s /bin/bash --bind "/opt/software,/data," "/opt/software/containers/singularity/openslideicr.sif"
fi
