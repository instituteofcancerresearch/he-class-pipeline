import pathlib
import sys
import os

from generate_cws import save_cws

def main(wsi_input,output_dir,in_mpp=None,out_mpp=0.22098959139024552,):    
    file_name_pattern = '*.ndpi'
    tif_obj = 40
    cws_objective_value = 20
    in_mpp = None
    out_mpp = None
    out_mpp_target_objective = 40
    num_cpu=4

        
    opts = {
        'output_dir': output_dir,
        'wsi_input': wsi_input,
        'tif_obj': tif_obj,
        'cws_objective_value': cws_objective_value,
        'in_mpp': in_mpp,
        'out_mpp': out_mpp,
        'out_mpp_target_objective': out_mpp_target_objective
            }

    save_cws.run(opts_in=opts, file_name_pattern=file_name_pattern, num_cpu=num_cpu)

if __name__ == '__main__':
    
    in_mpp=None
    out_mpp=0.22098959139024552
    output_dir = './output'
    wsi_input = './input/demo.ndpi'
    
    if len(sys.argv) > 1:
        wsi_input = sys.argv[1]
    
    if len(sys.argv) > 2:
        output_dir = sys.argv[2]
        
    if len(sys.argv) > 3:
        if sys.argv[3] != 'None':
           out_mpp = float(sys.argv[3])

    if len(sys.argv) > 4:
       	if sys.argv[4] != 'None':
            in_mpp = float(sys.argv[4])
    main(wsi_input,output_dir,in_mpp,out_mpp)
