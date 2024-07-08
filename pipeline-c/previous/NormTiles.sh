#!/bin/sh

#SBATCH -J "NormTiles"
#SBATCH -o /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/NormTiles.output.%j
#SBATCH -e /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/logs/NormTiles.errors.%j
#SBATCH -n 4
#SBATCH --mail-type="END,FAIL"
#SBATCH -t 24:00:00
#SBATCH --mail-user="nick.trahearn@icr.ac.uk"


module load anaconda/3
source activate pytorch0p3

cws_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Tiles_temp'
cws_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Masks'
out_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Norm2_temp'

#target_path='/data/scratch/DMP/UCEC/EVGENMOD/ntrahearn/Tiles/C4L/Discovery/TimePoint1/Tiles/SS-07-10783-2B.ndpi'
#target_mask_path='/data/scratch/DMP/UCEC/EVGENMOD/ntrahearn/Tiles/C4L/Discovery/TimePoint1/Masks/SS-07-10783-2B.ndpi'

#target_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Forecast/Final/Tiles/IM1416S2.czi'
#target_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Forecast/Final/Masks/IM1416S2.czi'

#target_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Missoni/Zeiss/065_DM_PD_P1.czi/'
#target_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Missoni/Masks/065_DM_PD_P1.czi/'

#target_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/PROMIS/ClassificationCohort/ImageTiles/P108002/P108002 C.ndpi/'
#target_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/PROMIS/ClassificationCohort/MaskTiles/P108002/P108002 C.ndpi/'

target_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Forecast/Final/Tiles_Norm/IM1012S4.czi'
target_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Forecast/Final/Masks/IM1012S4.czi'

norm_code_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Code/Norm/'

python -c "import sys; sys.path.append('${norm_code_path}'); from norm_cws import norm_cws_by_stats_batch; norm_cws_by_stats_batch('${cws_path}', '${target_path}', '${out_path}', '${cws_mask_path}', '${target_mask_path}', file_pattern='*.*')"
#python -c "import sys; sys.path.append('${norm_code_path}'); from norm_cws import norm_cws_by_stats_batch; norm_cws_by_stats('${cws_path}', '${target_path}', '${out_path}', '${cws_mask_path}', '${target_mask_path}', file_pattern='*.*')"
