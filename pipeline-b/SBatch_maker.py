# This writes in the format of a .sh file that can be submitted to the cluster
import sys

print(sys.argv)

working_dir = sys.argv[1]
pipeline_dir = sys.argv[2]
inB = sys.argv[3]
outB = sys.argv[4]
method = sys.argv[5]

batch_file = f"{working_dir}/b_run.sh"

with open(batch_file, "w") as f:
    f.write("#!/bin/sh\n")

with open(batch_file, "a") as f:
    f.write("#SBATCH -J HEBr\n")
    f.write("#SBATCH -o b_run.out\n")
    f.write("#SBATCH -e b_run.err\n")
    f.write("#SBATCH -n 4\n")
    f.write("#SBATCH -t 100:00:00\n")
    f.write("source ~/.bashrc\n")
    f.write("module load MATLAB/R2020b\n")
    f.write("echo 'Starting HEBr'\n")
    f.write("matlab -nodesktop -nosplash -r ")
    f.write('"')
    f.write(f"addpath(genpath('{pipeline_dir}/he-class-pipeline/pipeline-b/')); ")
    f.write(f"CreateMaskTilesBatch('{inB}', '{outB}', '")
    f.write(f'"{method}"')
    f.write("'); exit;")
    f.write('"')
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