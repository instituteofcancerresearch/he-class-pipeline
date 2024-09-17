#!/bin/sh
#SBATCH -p gpu
#SBATCH -J "HEDri"
#SBATCH -t 12:00:00
#SBATCH --gres=gpu:1


source ~/.bashrc

imageName=$1
code_path=$2
steps=$3
conda_dir=$4
tilePath=$5 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA"
segmentationTilePath=$6 #="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB"
cellDetectionResultsPath=$7 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD"
cellClassificationResultsPath=$8 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outE"
cellDetectorCheckPointPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellDetection/EPICC/Current/"

echo "imageName: $imageName"
echo "code_path: $code_path"
echo "steps: $steps"
echo "conda_dir: $conda_dir"
echo "tilePath: $tilePath"
echo "segmentationTilePath: $segmentationTilePath"
echo "cellDetectionResultsPath: $cellDetectionResultsPath"
echo "cellClassificationResultsPath: $cellClassificationResultsPath"
echo "cellDetectorCheckPointPath: $cellDetectorCheckPointPath"
conda_env1="$conda_dir/he-shared-tensorflow"
conda_env2="$conda_dir/he-shared-pytorch"
echo "conda_env1: $conda_env1"
echo "conda_env2: $conda_env2"

###################
echo "********************************"

currentPath=$code_path
###################
if [[ $steps == *"1"* ]]; then
    echo "script 1"
    mamba activate $conda_env1
    python3 --version
    python3 -m pip show matlabengine
    python3 -c "import sys; print(sys.argv)" "$file_name" "$code_path"
    #python3 -c "import tensorflow as tf; print(tf.__version__)"   
    ################################################### 
    
    sccnnDetectionCodePath="${currentPath}/cell_detector/analysis/"    
    detectionBatchSize=500
    ##################################################
    (cd "${sccnnDetectionCodePath}" && python3 "./Generate_Output.py" "${cellDetectorCheckPointPath}" "${tilePath}" "${cellDetectionResultsPath}" "${detectionBatchSize}" "${imageName}" "${segmentationTilePath}" "${matlabPath}")
    #(cd "${sccnnDetectionCodePath}" && source activate tf1p4 && python3 "./Generate_Output.py" "${cellDetectorCheckPointPath}" "${tilePath}" "${cellDetectionResultsPath}" "${detectionBatchSize}" "${imageName}" "${segmentationTilePath}")
    mamba deactivate
fi

if [[ $steps == *"2"* ]]; then
    echo "script 2"
    #source activate pytorch0p3
    mamba activate $conda_env2
    #python3 -c "import cv2;"
    #python3 -c "import torch;"
    #python3 -c "import fastai;"
    #python3 -c "from fastai.transforms import *;"
    #python3 -c "from fastai.conv_learner import *;"
    ###################
    classificationCodePath="${code_path}/cell_classifier/classification/"
    cellClassifierPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellClassification/EPICC/NDPI/Current/EPICC_Cell_Classifier_NDPI.h5"
    cellDetectionCSVPath="${cellDetectionResultsPath}/20180117/csv/"
    cellClassificationCSVPath="${cellClassificationResultsPath}/csv/"
    
    classificationBatchSize=50
    cellClassCertainty=0.0
    outputProbs=False
	overwrite=False
    noLabelIdx=4
    labelNames='["epithelial", "stromal", "immune", "unknown"]'
    ###################
    python3 -c "import sys; sys.path.append('${classificationCodePath}'); import processCSVs;processCSVs.processCSVs(imagePath='${imageName}', detectionPath='${cellDetectionCSVPath}', tilePath='${tilePath}',classifierPath='${cellClassifierPath}', outPath='${cellClassificationCSVPath}', segmentPath='${segmentationTilePath}', batchSize='${classificationBatchSize}', outLabels='${labelNames}',minProb='${cellClassCertainty}', noClassLabel='${noLabelIdx}', outputProbs='${outputProbs}', overwrite='${overwrite}');"
    # ------- function --------
    #def processCSVs(imagePath, detectionPath, tilePath, classifierPath, outPath, 
    #segmentPath=None, windowSize=[51, 51], cellImageSize=224, inLabels=None, 
    #outLabels=['nep', 'unk', 'myo', 'cep', 'fib', 'lym', 'neu', 'mac', 'end'], 
    #batchSize=30, arch=dn201, gpu=True, overwrite=False, minProb=0.0, noClassLabel=None, outputProbs=False):        
    # --------------------------
    mamba deactivate
fi

if [[ $steps == *"3"* ]]; then
    echo "script 3"

    module load MATLAB/R2020b

    imageScan="$imageName/FinalScan.ini"
    imageWidth=$(sed -n 's/iWidth=//p' "${imageScan}" | head -1)
    imageHeight=$(sed -n 's/iHeight=//p' "${imageScan}" | head -1)
    tileWidth=$(sed -n 's/iImageWidth=//p' "${imageScan}")
    tileHeight=$(sed -n 's/iImageHeight=//p' "${imageScan}")
    echo "imageScan: $imageScan" 
    echo "imageWidth: $imageWidth" 
    echo "imageHeight: $imageHeight"
    echo "tileWidth: $tileWidth"
    echo "tileHeight: $tileHeight"

    ###########################
    matlabPath="${currentPath}/cell_detector/matlab_common/"
    outputAnnotationCodePath="${currentPath}/cell_classifier/output_image_labelling/"
    mergeCSVCodePath="${currentPath}/cell_classifier/merge_csvs/"            
    ###########################

    matlabOpeningCommands="addpath(genpath('${matlabPath}'), genpath('${outputAnnotationCodePath}'), genpath('${mergeCSVCodePath}'));"

    echo "matlabOpeningCommands: $matlabOpeningCommands"
    
    ###########################
    dotAnnotationSize=6
    tifPath="${cellClassificationResultsPath}/tif/"
    tifFile="${tifPath}/${imageName%.*}_Annotated.tif"    
    smallDotTilePath="${cellClassificationResultsPath}/labelledImages/"
    labelFile="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/code/config/cell_labels.txt"
    ###########################
    
    matlabSmallDotCommands="WriteAnnotations('${imageName}', '${cellClassificationCSVPath}', '${tilePath}', '${smallDotTilePath}', '${labelFile}', ${dotAnnotationSize}); Tiles2TIF('${smallDotTilePath}/${imageName}/', [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], '${tifFile}', 'jpg', false);"
    
    ###########################
    dotAnnotationSize=30
    tifFile="${tifPath}/${imageName%.*}_AnnotatedBigDot.tif"
    bigDotTilePath="${cellClassificationResultsPath}/labelledImagesBigDot/"
    labelFile="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/he-class-pipeline/pipeline-d/code/config/cell_labels.txt"
    mergeCSVPath="${cellClassificationResultsPath}/all_cells/"
    ###########################
    
    matlabBigDotCommands="WriteAnnotations('${imageName}', '${cellClassificationCSVPath}', '${tilePath}', '${bigDotTilePath}', '${labelFile}', ${dotAnnotationSize}); Tiles2TIF('${bigDotTilePath}/${imageName}/', [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], '${tifFile}', 'jpg', false);"
    
    mergeCSVFile="${mergeCSVPath}/${imageName%.*}.csv"
    matlabMergeCSVCommands="MergeCSVs('${cellClassificationCSVPath}/${imageName}', '${tilePath}/${imageName}', '${mergeCSVFile}');"
    
    matlab -nodesktop -nosplash -r "${matlabOpeningCommands} ${matlabSmallDotCommands} ${matlabBigDotCommands} ${matlabMergeCSVCommands} exit;"   
fi

echo "complete"