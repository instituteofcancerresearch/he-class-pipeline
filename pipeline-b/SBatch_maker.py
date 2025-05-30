# This writes in the format of a .sh file that can be submitted to the cluster
import sys

print(sys.argv)

working_dir = sys.argv[1]
pipeline_dir = sys.argv[2]
inB = sys.argv[3]
outB = sys.argv[4]
method = sys.argv[5]
hpc = sys.argv[6]

batch_file = f"{working_dir}/b_run.sh"

with open(batch_file, "w") as f:
    if hpc == "sge":
        f.write("#!/bin/bash -l\n")
        f.write("#$ -N HEBr\n")
        f.write("#$ -o b_run.out\n")
        f.write("#$ -e b_run.err\n")
        f.write("#$ -pe smp 4\n")
        f.write("#$ -l h_rt=20:00:00\n")
        f.write(f"#$ -wd {working_dir}\n")
    else:
        f.write("#!/bin/sh\n")
        f.write("#SBATCH -J HEBr\n")
        f.write("#SBATCH -o b_run.out\n")
        f.write("#SBATCH -e b_run.err\n")
        f.write("#SBATCH -n 4\n")
        f.write("#SBATCH -t 100:00:00\n")
    
    f.write("\n")    
    #f.write("source ~/.bashrc\n")
    f.write("module load MATLAB/R2020b\n")    
    f.write("\n")
    f.write("echo 'Starting HEBr'\n")    
    f.write("MaskMethod=\"E\"\n")
    f.write("\n")
    f.write("module load matlab/full/r2023a/9.14\n")
    f.write("\n")
    f.write("matlab -nodesktop -nosplash -r ")
    f.write('"')
    f.write(f"addpath(genpath('{pipeline_dir}/pipeline-b/')); ")
    f.write(f"CreateMaskTilesBatch('{inB}', '{outB}', ")    
    f.write("'$MaskMethod'")
    f.write("); exit;\"")    

"""
#!/bin/sh
#SBATCH -J "HEBr"
#SBATCH -o b_run.out
#SBATCH -e b_run.err
#SBATCH -n 4
#SBATCH -t 100:00:00

source ~/.bashrc
module load MATLAB/R2020b
matlab -nodesktop -nosplash -r "addpath(genpath('./he-class-pipeline/pipeline-b/')); CreateMaskTilesBatch('./outA/', './outB/', '"T"'); exit;"
"""


"""
MaskMethod="E";
Params="'jpg', [3.5 5000 225]"
module load MATLAB
matlab -nodesktop -nosplash -r "addpath(genpath('${codePath}')); CreateMaskTilesBatch('$ImageTilesPath', '$MaskTilesPath', '$MaskMethod', $Params); exit;" 
"""
 