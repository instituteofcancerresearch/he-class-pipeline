# From here: 
https://github.com/sottorivalab/FORECAST_cell_classification


3. set off batch
navigate to the directory pipeline-b and set off the batch file. 3 inputs are log-dir, data-input-dir, singularity-sif-location.  

```bash
sbatch tst1.sh . . .
```

It mounts the current drive to log so it can write a dummy file out with the gpus in gpu-log.txt

---  
Resources
https://guiesbibtic.upf.edu/recerca/hpc/running-singularity-containers-with-gpu
https://nexus.icr.ac.uk/strategic-initiatives/sc/hpc/userguides/Pages/Use-Cases.aspx
https://docs.sylabs.io/guides/3.0/user-guide/bind_paths_and_mounts.html
https://hub.docker.com/r/tensorflow/tensorflow/tags


