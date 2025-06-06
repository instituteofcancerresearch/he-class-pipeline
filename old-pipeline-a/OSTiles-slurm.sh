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
CondaPath=$4
OpenSlideContainerPath=$5

if [[ "$is_singularity" == "TRUE" ]]; then    
	echo "Running the script in the singularity container..."
    echo "CodePath: $CodePath"
    echo "ImageDir: $ImageDir"
    echo "TilePath: $TilePath"
    echo "CondaPath: $CondaPath"
    echo "SingPath: $SingPath"
    
    ImageFileExtension="ndpi"
    InMPP=None
    OutMPP=0.22098959139024552
    OutMPP=None
        	
    source /data/scratch/shared/RSE/sources/.rachel
    module load java/jdk15.0.1
    #mamba activate /data/scratch/shared/RSE/.conda/envs/openslide-mod    
    #echo "Using mamba"
    source activate $CondaPath
    echo "Path: $PATH"
    echo "Python version: $(python --version)"
    echo "Python path: $(which python)"    
    mkdir -p "$TilePath"
    python -c "print('Using python')"

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
    echo "OpenSlideContainerPath: $OpenSlideContainerPath"
    export SINGULARITYENV_is_singularity="TRUE"
    #OpenSlideContainerPath="/opt/software/containers/singularity/openslideicr.sif"
    singularity exec --bind "/opt/software,/data," "$OpenSlideContainerPath" "$0" "$1" "$2" "$3" "$4"
    echo "Finished"
fi
