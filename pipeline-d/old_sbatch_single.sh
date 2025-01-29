#!/bin/sh
#SBATCH -p gpu
#SBATCH -J "HEDri"
#SBATCH -t 12:00:00
#SBATCH --gres=gpu:1


#source /data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/home/.bashrc
#source /data/scratch/shared/RSE/sources/.rachel
source /data/scratch/shared/RSE/sources/.nick
module load anaconda/3

imagePath=$1
imageName=$2
code_root=$3
steps=$4
conda_env1=$5
conda_env2=$6
tilePath=$7 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outA"
segmentationTilePath=$8 #="/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outB"
cellDetectionResultsPath=$9 #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outD"
cellClassificationResultsPath=${10} #"/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier/outE"
cellDetectorCheckPointPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellDetection/EPICC/Current/"

echo "*********INPUTS***********************"
echo "old_sbatch_single.sh"
echo "imagePath: $imagePath"
echo "imageName: $imageName"
echo "code_root: $code_root"
echo "steps: $steps"
echo "tilePath: $tilePath"
echo "segmentationTilePath: $segmentationTilePath"
echo "cellDetectionResultsPath: $cellDetectionResultsPath"
echo "cellClassificationResultsPath: $cellClassificationResultsPath"
echo "cellDetectorCheckPointPath: $cellDetectorCheckPointPath"
echo "********************************"
code_path="$code_root/code"
config_path="$code_root/config"
echo "conda_env1: $conda_env1"
echo "conda_env2: $conda_env2"
echo "code_path: $code_path"
echo "config_path: $config_path"

###################
echo "********************************"

currentPath=$code_path
matlabPath="${currentPath}/cell_detector/matlab_common/"
###################
if [[ $steps == *"1"* ]]; then
    echo "@@@@@@@@@@@@ script 1 @@@@@@@@@@@@"    
    #mamba activate $conda_env1
    source activate $conda_env1
    echo "Python version: $(python --version)"
    echo "Python path: $(which python)"        
    python3 -m pip show matlabengine
    python3 -c "import sys; print(sys.argv)" "$file_name" "$code_path"   

    ##################################################
    echo "Check tensorflow installation"
    python3 -c "import tensorflow as tf;print('Num GPUs Available: ', len(tf.test.gpu_device_name()))"
    ################################################### 
    
    sccnnDetectionCodePath="${currentPath}/cell_detector/analysis"    
    detectionBatchSize=500
    ##################################################
    (cd "${sccnnDetectionCodePath}" && \
    python3 "./Generate_Output.py" "${cellDetectorCheckPointPath}" "${tilePath}" \
    "${cellDetectionResultsPath}" "${detectionBatchSize}" "${imageName}" \
    "${segmentationTilePath}" "${matlabPath}")    
    #mamba deactivate
    conda deactivate
fi

if [[ $steps == *"2"* ]]; then
    echo "@@@@@@@@@@@@ script 2 @@@@@@@@@@@@"    
    #mamba activate $conda_env2
    source activate $conda_env2
    ###################
    classificationCodePath="${code_path}/cell_classifier/classification"
    cellClassifierPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellClassification/EPICC/NDPI/Current/EPICC_Cell_Classifier_NDPI.h5"
    cellDetectionCSVPath="${cellDetectionResultsPath}/20180117/csv"
    cellClassificationCSVPath="${cellClassificationResultsPath}/csv"
    
    classificationBatchSize=50
    cellClassCertainty=0.0
    outputProbs=False
	overwrite=False
    #labelNames='["nep", "unk", "myo", "cep", "fib", "lym", "neu", "mac", "end"]'                
    noLabelIdx=1
    ###################
    echo "=======Calling processCSVs with the following parameters: ====="
    echo "classificationCodePath: $classificationCodePath"
    echo "imageName: $imageName"        
    echo "detectionPath: ${cellDetectionCSVPath}"
    echo "tilePath: ${tilePath}"
    echo "classifierPath: ${cellClassifierPath}"
    echo "outPath: ${cellClassificationCSVPath}"
    echo "segmentPath: ${segmentationTilePath}"
    echo "batchSize: ${classificationBatchSize}"
    #echo "inLabels: ${labelNames}"
    #echo "outLabels: ${labelNames}"
    echo "minProb: ${cellClassCertainty}"
    echo "noClassLabel: ${noLabelIdx}"
    echo "outputProbs: ${outputProbs}"
    echo "overwrite: ${overwrite})"
    echo "======================="

    python3 -c "import sys; sys.path.append('${classificationCodePath}'); \
    import processCSVs;processCSVs.processCSVs(imagePath='${imageName}', \
    detectionPath='${cellDetectionCSVPath}', \
    tilePath='${tilePath}',classifierPath='${cellClassifierPath}', \
    outPath='${cellClassificationCSVPath}', segmentPath='${segmentationTilePath}', \
    batchSize='${classificationBatchSize}', \
    minProb='${cellClassCertainty}', noClassLabel='${noLabelIdx}', \
    outputProbs='${outputProbs}', overwrite='${overwrite}');"    
    #inLabels='${labelNames}', outLabels='${labelNames}',\
    
    #mamba deactivate
    conda deactivate
fi

if [[ $steps == *"3"* ]]; then
    echo "@@@@@@@@@@@@ script 3 @@@@@@@@@@@@"    

    module load MATLAB/R2020b

    echo "=========variables=============="
    imageScan="$imagePath/FinalScan.ini"
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
    cellClassificationCSVPath="${cellClassificationResultsPath}/csv"
    matlabPath="${currentPath}/cell_detector/matlab_common/"
    outputAnnotationCodePath="${currentPath}/cell_classifier/output_image_labelling/"
    mergeCSVCodePath="${currentPath}/cell_classifier/merge_csvs/"                
    ###########################

    matlabOpeningCommands="addpath(genpath('${matlabPath}'), \
    genpath('${outputAnnotationCodePath}'), genpath('${mergeCSVCodePath}'));"

    echo "matlabOpeningCommands: $matlabOpeningCommands"
    
    ###########################
    dotAnnotationSize=6
    tifPath="${cellClassificationResultsPath}/tif"
    tifFile="${tifPath}/${imageName%.*}_Annotated.tif"    
    smallDotTilePath="${cellClassificationResultsPath}/labelledImages"
    labelFile="${config_path}/cell_labels.txt"
    ###########################

    echo "=======SMALL DOT================"
    echo "Calling matLab WriteAnnotations with the following parameters:"
    echo "imageName: $imageName"
    echo "cellClassificationCSVPath: $cellClassificationCSVPath"
    echo "tilePath: $tilePath"
    echo "smallDotTilePath: $smallDotTilePath"
    echo "labelFile: $labelFile"
    echo "dotAnnotationSize: $dotAnnotationSize"
    echo "======================="
    echo "Calling matLab Tiles2TIF with the following parameters:"
    echo "smallDotTilePath:${smallDotTilePath}/${imageName}"
    echo "tileWidth: $tileWidth"
    echo "tileHeight: $tileHeight"
    echo "imageWidth: $imageWidth"
    echo "imageHeight: $imageHeight"
    echo "tifFile: $tifFile"
    echo "jpg"
    echo "false"
    
    matlabSmallDotCommands="WriteAnnotations('${imageName}', \
    '${cellClassificationCSVPath}', \
    '${tilePath}', \
    '${smallDotTilePath}', \
    '${labelFile}', \
    ${dotAnnotationSize}); \
    Tiles2TIF('${smallDotTilePath}/${imageName}', \
    [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], \
    '${tifFile}', 'jpg', false);"
    
    ###########################
    dotAnnotationSize=30
    tifFile="${tifPath}/${imageName%.*}_AnnotatedBigDot.tif"
    bigDotTilePath="${cellClassificationResultsPath}/labelledImagesBigDot"
    labelFile="${config_path}/cell_labels.txt"
    mergeCSVPath="${cellClassificationResultsPath}/all_cells"
    mkdir -p $mergeCSVPath
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
    echo "bigDotTilePath:${bigDotTilePath}/${imageName}"
    echo "tileWidth: $tileWidth"
    echo "tileHeight: $tileHeight"
    echo "imageWidth: $imageWidth"
    echo "imageHeight: $imageHeight"
    echo "tifFile: $tifFile"
    echo "jpg"
    echo "false"    
    
    matlabBigDotCommands="WriteAnnotations('${imageName}', \
    '${cellClassificationCSVPath}', \
    '${tilePath}', '${bigDotTilePath}', \
    '${labelFile}', \
    ${dotAnnotationSize}); \
    Tiles2TIF('${bigDotTilePath}/${imageName}', \
    [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], \
    '${tifFile}', 'jpg', false);"
    
    mergeCSVFile="${mergeCSVPath}/${imageName%.*}.csv"

    echo "=======MERGE CSV================"
    echo "Calling matLab MergeCSVs with the following parameters:"
    echo "mergeClassificationCSVPath: $cellClassificationCSVPath/${imageName}"
    echo "tilePath: $tilePath/${imageName}"
    echo "mergeCSVFile: $mergeCSVFile"
    echo "======================="
    matlabMergeCSVCommands="MergeCSVs('${cellClassificationCSVPath}/${imageName}', \
    '${tilePath}/${imageName}', '${mergeCSVFile}');"
    
    echo "=======MATLAB COMMANDS================"
    echo "matlabOpeningCommands: $matlabOpeningCommands"
    echo "matlabSmallDotCommands: $matlabSmallDotCommands"
    echo "matlabBigDotCommands: $matlabBigDotCommands"
    echo "matlabMergeCSVCommands: $matlabMergeCSVCommands"

    matlab -nodesktop -nosplash -r "${matlabOpeningCommands} \
    ${matlabSmallDotCommands} ${matlabBigDotCommands} \
    ${matlabMergeCSVCommands} exit;"   
fi

echo ""
echo "Complete"