
# This writes in the format of a .sh file that can be submitted to the cluster
import sys

print(sys.argv)

working_dir = sys.argv[1]
sing_dir = sys.argv[2]
pipeline_dir = sys.argv[3]
inA = sys.argv[4]
outA = sys.argv[5]
pattern = sys.argv[6]

batch_file = f"{working_dir}/a_run.sh"

with open(batch_file, "w") as f:
    f.write("#!/bin/sh\n")

with open(batch_file, "a") as f:
    """    
    input_path = args[0]
    output_path = args[1]
    log_path = args[2]
    container_path = args[3].upper()
    overwrite = args[4].upper()
    pattern = args[5]
    """
    sing_call = f"singularity run "
    sing_call += f"-B {inA}:/input "
    sing_call += f"-B {outA}:/output "    
    sing_call += f"-B {working_dir}:/log "    
    sing_call += f"{sing_dir}/HEA.sif "
    sing_call += f"/input /output /log Y Y {pattern}"
            
    f.write("#SBATCH -J HEAr\n")
    f.write("#SBATCH -o a_run.out\n")
    f.write("#SBATCH -e a_run.err\n")
    f.write("#SBATCH -n 4\n")
    f.write("#SBATCH -t 100:00:00\n")
    f.write("source ~/.bashrc\n")        
    f.write(f"echo '********'\n")    
    f.write(f"echo '{sing_call}'\n")    
    f.write(f"echo '********'\n")       
    f.write("echo 'Starting HEAr'\n")        
    f.write(f"srun {sing_call}")


"""
mkdir -p /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev;
cd /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev;
mkdir -p /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA;
sbatch -o a_run.out -e a_run.err -J HEAr --wrap="
srun singularity run 
-B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/testNDPIs:/input 
-B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA:/output 
-B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev:/log 
/data/scratch/shared/SINGULARITY-DOWNLOAD/tools/.singularity/HEA.sif 
/input /output /log Y Y *.ndpi";
"""