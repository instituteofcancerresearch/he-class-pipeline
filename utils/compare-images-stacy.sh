#!/bin/bash

source ~/.bashrc

cd /data/scratch/DCO/DIGOPS/SCIENCOM/ashcherbakova/he-app-test/

# conda init
echo -e "Activating conda enviroment..."
# conda activate comprate-images-env
mamba activate comprate-images-env

echo -e "Running compare images script..."
python3 compare-images.py "$1" "$2" > compare-images-result.log 2> compare-images-result.err

echo -e "Result output:"
cat compare-images-result.log

# conda init
echo -e "Deactivating conda enviroment..."
# conda deactivate
mamba deactivate