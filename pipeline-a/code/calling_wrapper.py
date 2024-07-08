
import sys
import datetime
import generate_cws
import glob
import os
import shutil

def main(args):
    print("Starting OpenSlide ICR...")
    print(args)
    input_path = args[0]
    output_path = args[1]
    container_path = args[2].upper()
    overwrite = args[3].upper()
    pattern = args[4]
    print(f"Pattern: {pattern}")
    if container_path == "Y":        
        input_path = "/input"
        output_path = "/output"

    output_log = f"{output_path}/p-log.txt"
    print(f"Input path: {input_path}")
    print(f"Output path: {output_path}")
    print(f"Output log: {output_log}")
    
    #onlyfiles = [f for f in listdir(input_path) if isfile(join(input_path, f))]            
    path = f'{input_path}/{pattern}'
    matching_files = glob.glob(path)    
    print(f"Matching files: {matching_files}")

    if os.path.exists(output_log):
        with open(output_log, "a") as f:
            f.write(f"{datetime.datetime.now()}\tStarting OpenSlide ICR\n")
    else:
        with open(output_log, "w") as f:
            f.write(f"{datetime.datetime.now()}\tStarting OpenSlide ICR\n")

    for i in range(len(matching_files)):
        fl = matching_files[i]
        with open(output_log, "a") as f:
            f.write(f"{datetime.datetime.now()}\t{i+1}/{len(matching_files)}: {fl}\n")                        
        print(fl)
        if not os.path.exists(output_path):
            os.makedirs(output_path, exist_ok=True)
        else:
            if overwrite == "Y":
                fi = os.path.basename(fl)
                fo = f"{output_path}/{fi}"                                            
                if os.path.exists(fo):
                    shutil.rmtree(fo)                                
                    print(f"Removed {fo} to replace")

        
        generate_cws.save_cws.run(opts_in={'output_dir': output_path, 'wsi_input': fl, 'tif_obj': 40, 'cws_objective_value': 20, 'in_mpp': None, 'out_mpp': None, 'out_mpp_target_objective': 40}, file_name_pattern=pattern, num_cpu=4) 
        
    print("Finished OpenSlide ICR")
    with open(output_log, "a") as f:
        f.write(f"{datetime.datetime.now()}\tcomplete\n")
        f.write("------------------------------------\n")

if __name__ == '__main__':
    main(sys.argv[1:])
    
#main("pipelines/in-a","pipelines/out-a","Y","Y","*.*")