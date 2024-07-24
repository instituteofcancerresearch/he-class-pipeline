

# First conda environment
mamba create -n tf-1 tensorflow-gpu
mamba activate tf-1
mamba install anaconda::pillow
python -m pip install wheels
python3 -m pip install matlabengine

# run the script 1
cd code/cell_detector/analysis
mamba activate tf-gpu1
python3 ./Generate_Output.py cellDetectorCheckPointPath tilePath cellDetectionResultsPath detectionBatchSize imageName segmentationTilePath


/opt/software/applications/MATLAB/R2023b/extern/engines/python

cd "/mnt/c/Program Files/MATLAB/R2023a/extern/engines/python"

c from linux: 
