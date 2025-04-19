



# D1
conda activate /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/tfAlmaGPU1p4
cp -r /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/tfAlmaGPU1p4 /data/rds/DIT/SCICOM/SCRSE/shared/conda/tfAlmaGPU1p4
source activate /data/rds/DIT/SCICOM/SCRSE/shared/conda/tfAlmaGPU1p4
```
echo "Python version: $(python --version)"
echo "Python path: $(which python)"        
python3 -m pip show matlabengine
python3 -c "import sys; print(sys.argv)" "$file_name" "$code_path"           
python3 -c "import tensorflow as tf;print('Num GPUs Available: ', len(tf.test.gpu_device_name()))"
```

D2: 
cp -r /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/pytorch0p3 /data/rds/DIT/SCICOM/SCRSE/shared/conda/pytorch0p3
Then the deny needs to be removed from the access settgings :-( 
source activate /data/rds/DIT/SCICOM/SCRSE/shared/conda/pytorch0p3
echo "Python path: $(which python)"
