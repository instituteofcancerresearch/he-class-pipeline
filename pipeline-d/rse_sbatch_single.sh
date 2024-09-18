#!/bin/sh
#SBATCH -p gpu
#SBATCH -J "HEDri"
#SBATCH -t 12:00:00
#SBATCH --gres=gpu:1


source ~/.bashrc

imageName=$1
imageBase=$2
code_root=$3
steps=$4
conda_dir=$5
tilePath=$6 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA"
segmentationTilePath=$7 #="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB"
cellDetectionResultsPath=$8 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD"
cellClassificationResultsPath=$9 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outE"
cellDetectorCheckPointPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellDetection/EPICC/Current/"

echo "*********INPUTS***********************"
echo "imageName: $imageName"
echo "imageBase: $imageBase"
echo "code_root: $code_root"
echo "steps: $steps"
echo "conda_dir: $conda_dir"
echo "tilePath: $tilePath"
echo "segmentationTilePath: $segmentationTilePath"
echo "cellDetectionResultsPath: $cellDetectionResultsPath"
echo "cellClassificationResultsPath: $cellClassificationResultsPath"
echo "cellDetectorCheckPointPath: $cellDetectorCheckPointPath"
echo "********************************"
conda_env1="$conda_dir/he-shared-tensorflow"
conda_env2="$conda_dir/he-shared-pytorch"
code_path="$code_root/code"
config_path="$code_root/config"
echo "conda_env1: $conda_env1"
echo "conda_env2: $conda_env2"
echo "code_path: $code_path"
echo "config_path: $config_path"

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

    echo "=========variables=============="
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
    echo "======================="

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
    tifFile="${tifPath}/${imageBase%.*}_Annotated.tif"    
    smallDotTilePath="${cellClassificationResultsPath}/labelledImages/"
    labelFile="${config_path}/cell_labels.txt"
    ###########################

    echo "=======SMALL DOT================"
    echo "Calling matLab WriteAnnoatioans with the following parameters:"
    echo "imageName: $imageName"
    echo "cellClassificationCSVPath: $cellClassificationCSVPath"
    echo "tilePath: $tilePath"
    echo "smallDotTilePath: $smallDotTilePath"
    echo "labelFile: $labelFile"
    echo "dotAnnotationSize: $dotAnnotationSize"
    echo "======================="
    echo "Calling matLab Tiles2TIF with the following parameters:"
    echo "smallDotTilePath:${smallDotTilePath}/${imageBase}/"
    echo "tileWidth: $tileWidth"
    echo "tileHeight: $tileHeight"
    echo "imageWidth: $imageWidth"
    echo "imageHeight: $imageHeight"
    echo "tifFile: $tifFile"
    echo "jpg"
    echo "false"
    
    matlabSmallDotCommands="WriteAnnotations('${imageName}', '${cellClassificationCSVPath}', '${tilePath}', '${smallDotTilePath}', '${labelFile}', ${dotAnnotationSize}); Tiles2TIF('${smallDotTilePath}/${imageBase}/', [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], '${tifFile}', 'jpg', false);"
    
    ###########################
    dotAnnotationSize=30
    tifFile="${tifPath}/${imageBase%.*}_AnnotatedBigDot.tif"
    bigDotTilePath="${cellClassificationResultsPath}/labelledImagesBigDot/"
    labelFile="${config_path}/cell_labels.txt"
    mergeCSVPath="${cellClassificationResultsPath}/all_cells/"
    ###########################

    echo "=======BIG DOT================"
    echo "Calling matLab WriteAnnoatioans with the following parameters:"
    echo "imageName: $imageName"
    echo "cellClassificationCSVPath: $cellClassificationCSVPath"
    echo "tilePath: $tilePath"
    echo "bigDotTilePath: $bigDotTilePath"
    echo "labelFile: $labelFile"
    echo "dotAnnotationSize: $dotAnnotationSize"
    echo "======================="
    echo "Calling matLab Tiles2TIF with the following parameters:"
    echo "bigDotTilePath:${bigDotTilePath}/${imageBase}/"
    echo "tileWidth: $tileWidth"
    echo "tileHeight: $tileHeight"
    echo "imageWidth: $imageWidth"
    echo "imageHeight: $imageHeight"
    echo "tifFile: $tifFile"
    echo "jpg"
    echo "false"    
    
    matlabBigDotCommands="WriteAnnotations('${imageName}', '${cellClassificationCSVPath}', '${tilePath}', '${bigDotTilePath}', '${labelFile}', ${dotAnnotationSize}); Tiles2TIF('${bigDotTilePath}/${imageBase}/', [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], '${tifFile}', 'jpg', false);"
    
    mergeCSVFile="${mergeCSVPath}/${imageName%.*}.csv"

    echo "=======MERGE CSV================"
    echo "Calling matLab MergeCSVs with the following parameters:"
    echo "cellClassificationCSVPath: $cellClassificationCSVPath/${imageName}"
    echo "tilePath: $tilePath/${imageName}"
    echo "mergeCSVFile: $mergeCSVFile"
    echo "======================="
    matlabMergeCSVCommands="MergeCSVs('${cellClassificationCSVPath}/${imageName}', '${tilePath}/${imageName}', '${mergeCSVFile}');"
    
    matlab -nodesktop -nosplash -r "${matlabOpeningCommands} ${matlabSmallDotCommands} ${matlabBigDotCommands} ${matlabMergeCSVCommands} exit;"   
fi

echo "complete"