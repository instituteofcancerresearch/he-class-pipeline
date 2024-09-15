import sys
import datetime
from Norm.norm_cws import norm_cws_by_stats_batch
import os

#cws_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Tiles_temp'
#cws_mask_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Masks'
#out_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/STAMPEDE/Norm2_temp'
#target_path='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/Forecast/Final/Tiles_Norm/IM1012S4.czi'

def main(args):
    print("Calling pipeline C:Norm with args",args)
    cws_path = args[0]
    target_path = sys.argv[1]
    out_path = args[2]
    log_path = args[3]
    cws_mask_path = args[4]
    target_mask_path = args[5]
    file_pattern = args[6]
                        
    
    output_log = f"{log_path}/c_log.txt"
    print(f"Input path: {cws_path}")
    print(f"Output path: {out_path}")
    print(f"Output log: {output_log}")
    
    if os.path.exists(output_log):
        with open(output_log, "a") as f:
            f.write(f"{datetime.datetime.now()}\tStarting H&E Pipeline:C:Norm\n")
    else:
        with open(output_log, "w") as f:
            f.write(f"{datetime.datetime.now()}\tStarting H&E Pipeline:C:Norm\n")

    norm_cws_by_stats_batch(cws_path, target_path, out_path, cws_mask_path, target_mask_path, file_pattern=file_pattern)
    
    print("Finished H&E Pipeline:C:Norm")
    with open(output_log, "a") as f:
        f.write(f"{datetime.datetime.now()}\tcomplete\n")
        f.write("------------------------------------\n")
    
if __name__ == '__main__':    
    main(sys.argv[1:])
    
    



