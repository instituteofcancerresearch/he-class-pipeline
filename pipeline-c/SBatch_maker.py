# This writes in the format of a .sh file that can be submitted to the cluster
import sys

print(sys.argv)

working_dir = sys.argv[1]
sing_dir = sys.argv[2]
pipeline_dir = sys.argv[3]
inC_tiles = sys.argv[4]
inC_masks = sys.argv[5]
inC_refTiles = sys.argv[6]
inC_refMasks = sys.argv[7]
outC = sys.argv[8]
pattern = sys.argv[9]


batch_file = f"{working_dir}/c_run.sh"

with open(batch_file, "w") as f:
    f.write("#!/bin/sh\n")

with open(batch_file, "a") as f:
    f.write("#SBATCH -J HECr\n")
    f.write("#SBATCH -o c_run.out\n")
    f.write("#SBATCH -e c_run.err\n")
    f.write("#SBATCH -n 4\n")
    f.write("#SBATCH -t 100:00:00\n")
    f.write("source ~/.bashrc\n")        
    f.write("echo 'Starting HECr'\n")    
    f.write("srun singularity run ")    
    f.write(f"-B {inC_tiles}:/input_tiles ")    
    f.write(f"-B {inC_refTiles}:/target_tiles ")    
    f.write(f"-B {outC}:/output ")    
    f.write(f"-B {working_dir}:/log ")    
    f.write(f"-B {inC_masks}:/input_masks ")    
    f.write(f"-B {inC_refMasks}:/target_masks ")    
    f.write(f"{sing_dir}/HEC.sif /input_tiles /target_tiles /output /log /input_masks /target_masks *.*")    
            
"""
#!/bin/sh
#SBATCH -J "HEBr"
#SBATCH -o b_run.out
#SBATCH -e b_run.err
#SBATCH -n 4
#SBATCH -t 100:00:00

srun singularity run 
-B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA:/input_tiles 
-B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB:/target_tiles 
-B /data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outC:/output 
-B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/NormTiles/C4L/Tiles:/input_masks 
-B /data/rds/DMP/UCEC/GENEVOD/ntrahearn/Images/ClassifierPipelineDemoImages/NormTiles/C4L/Masks:/target_masks 
HEC.sif /input_tiles /target_tiles /output /input_masks /target_masks *.*;";
"""