import pathlib
import sys
import os

if os.name == 'nt':
    os.environ['PATH'] = "C:\\tools\\openslide-win64-20171122\\bin" + ";" + os.environ['PATH']

from generate_cws import save_cws


if __name__ == '__main__':
    wsi_input = str(pathlib.Path(r'X:\tmp\John_1000Adeno\raw\ACA1_7-2014-12-07_13.25.14.ndpi'))
    output_dir = str(pathlib.Path(r'X:\tmp\John_1000Adeno\cws'))
    file_name_pattern = '*.ndpi'
    tif_obj = 40
    cws_objective_value = 20
    in_mpp = None
    out_mpp = None
    out_mpp_target_objective = 40

    if len(sys.argv) > 1:
        wsi_input = sys.argv[1]
        if os.path.isfile(wsi_input):
            dir_path, _ = os.path.split(wsi_input)
            output_dir = os.path.join(dir_path, '..', 'cws')
        elif os.path.isdir(wsi_input):
            output_dir = os.path.join(wsi_input, '..', 'cws')

    if len(sys.argv) > 2:
        if sys.argv[2] != 'None':
           out_mpp = float(sys.argv[2])

    if len(sys.argv) > 3:
       	if sys.argv[3] != 'None':
            in_mpp = float(sys.argv[3])

    if len(sys.argv) > 4:
        output_dir = sys.argv[4]

    opts = {
        'output_dir': output_dir,
        'wsi_input': wsi_input,
        'tif_obj': tif_obj,
        'cws_objective_value': cws_objective_value,
        'in_mpp': in_mpp,
        'out_mpp': out_mpp,
        'out_mpp_target_objective': out_mpp_target_objective
            }

    save_cws.run(opts_in=opts, file_name_pattern=file_name_pattern, num_cpu=4)
