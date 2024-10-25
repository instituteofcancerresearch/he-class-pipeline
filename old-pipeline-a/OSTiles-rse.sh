#!/bin/bash

#SBATCH -J "HEAr"
#SBATCH -o a_run.out
#SBATCH -e a_run.err
#SBATCH -n 8
#SBATCH --mail-type="END,FAIL"
#SBATCH -t 100:00:00
#is_singularity="TRUE"

#ImageDir="/data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs/"
#TilePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/out/"
#CodePath="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-old/Code/OSTiles/"
CodePath=$1
ImageDir=$2
TilePath=$3

if [[ "$is_singularity" == "TRUE" ]]; then    
	echo "Running the script in the singularity container..."
    echo "CodePath: $CodePath"
    echo "ImageDir: $ImageDir"
    echo "TilePath: $TilePath"
    
    ImageFileExtension="ndpi"
    InMPP=None
    OutMPP=0.22098959139024552
    OutMPP=None
        	
    source /data/scratch/shared/RSE/sources/.nick    
    module load anaconda/3 java/jdk15.0.1		    	
    source activate /data/scratch/shared/RSE/.conda/envs/openslide-mod-rse
    echo "Python version: $(python3 --version)"
    echo "Python path: $(which python3)"    
    mkdir -p "$TilePath"

    # count through the loop before exectuting it
    ImageCount=0
    for ImagePath in "$ImageDir"/*."$ImageFileExtension"; do        
        ImageCount=$((ImageCount+1))
        echo "Counting $ImagePath" $ImageCount
    done

    ImageI=0
    for ImagePath in "$ImageDir"/*."$ImageFileExtension"; do
        ImageI=$((ImageI+1))
        echo "Processing $ImagePath"
        ImageFileName=$(basename "$ImagePath")
        python3 "$CodePath/generate_cws.py" "$ImagePath" $OutMPP $InMPP "$TilePath" $ImageI $ImageCount
    done
else    
	echo "Setting up the singularity container..."
    export SINGULARITYENV_is_singularity="TRUE"
    OpenSlideContainerPath="/opt/software/containers/singularity/openslideicr.sif"
    singularity exec --bind "/opt/software,/data," "$OpenSlideContainerPath" "$0" "$1" "$2" "$3"
    echo "Finished"
fi
