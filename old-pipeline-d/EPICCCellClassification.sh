#!/bin/bash

tilePath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/test1/Norm1/"
segmentationTilePath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Tiles/test1/Masks1/"
outputPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Analysis/test4/"

cellDetectorCheckPointPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models//CellDetection/EPICC/Current/"
cellClassifierPath="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models//CellClassification/EPICC/NDPI/Current/EPICC_Cell_Classifier_NDPI.h5"

labelFile="/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/config/CellClassification/AnnotationLabels/EPICC_labels.txt"
labelNames="['nep', 'unk', 'myo', 'cep', 'fib', 'lym', 'neu', 'mac', 'end']"
noLabelIdx=1

detectionBatchSize=500
classificationBatchSize=50
cellClassCertainty=0.0
outputProbs=False

if [ $# -gt 0 ]; then
    all_files=("$tilePath"/*/)
    files=()
    for var in "$@"; do
        files+=("${all_files[$((var-1))]}")
    done
else
    files=("$tilePath"/*/)
fi

currentPath=$(dirname "${0}")

codePath="${currentPath}/.."
sccnnDetectionCodePath="${codePath}/SCCNNDetection/20180109/"
classificationCodePath="${codePath}/EPICCCellClassification/"
matlabPath="${codePath}/matlab/"
outputAnnotationCodePath="${codePath}/AnnotationGeneration/Output/"
mergeCSVCodePath="${codePath}/../MergeCSVs/"
makeThumbnailsCodePath="${codePath}/../MakeTIFFThumbnails/"

cellDetectionResultsPath="${outputPath}/Detection/"
cellClassificationResultsPath="${outputPath}/Classification/"
cellDetectionCSVPath="${cellDetectionResultsPath}/20180117/csv/"
cellClassificationCSVPath="${cellClassificationResultsPath}/csv/"
smallDotTilePath="${cellClassificationResultsPath}/labelledImages/"
bigDotTilePath="${cellClassificationResultsPath}/labelledImagesBigDot/"
tifPath="${cellClassificationResultsPath}/tif/"
mergedCSVPath="${cellClassificationResultsPath}/all_cells/"

for file in "${files[@]}"; do
    imageName="$(basename "$file")"

    imageWidth=$(sed -n 's/iWidth=//p' "${tilePath}/${imageName}/FinalScan.ini" | head -1)
    imageHeight=$(sed -n 's/iHeight=//p' "${tilePath}/${imageName}/FinalScan.ini" | head -1)
    tileWidth=$(sed -n 's/iImageWidth=//p' "${tilePath}/${imageName}/FinalScan.ini")
    tileHeight=$(sed -n 's/iImageHeight=//p' "${tilePath}/${imageName}/FinalScan.ini")

    (cd "${sccnnDetectionCodePath}" && source activate tfAlmaGPU1p4 && python3 "./Generate_Output_NTCustom.py" "${cellDetectorCheckPointPath}" "${tilePath}" "${cellDetectionResultsPath}" "${detectionBatchSize}" "${imageName}" "${segmentationTilePath}")

    source activate pytorch0p3

    cellClassificationCSVPath="${cellClassificationResultsPath}/csv/"

    python3 -c "import sys; sys.path.append('${classificationCodePath}'); import processCSVs; processCSVs.processCSVs('${imageName}', '${cellDetectionCSVPath}', '${tilePath}', '${cellClassifierPath}', '${cellClassificationCSVPath}', segmentPath='${segmentationTilePath}', batchSize=${classificationBatchSize}, outLabels=${labelNames}, minProb=${cellClassCertainty}, noClassLabel=${noLabelIdx}, outputProbs=${outputProbs})"

    matlabOpeningCommands="addpath(genpath('${matlabPath}'), genpath('${outputAnnotationCodePath}'), genpath('${mergeCSVCodePath}'), genpath('${makeThumbnailsCodePath}'));"

    dotAnnotationSize=6
    tifFile="${tifPath}/${imageName%.*}_Annotated.tif"

    matlabSmallDotCommands="WriteAnnotations('${imageName}', '${cellClassificationCSVPath}', '${tilePath}', '${smallDotTilePath}', '${labelFile}', ${dotAnnotationSize}); Tiles2TIF('${smallDotTilePath}/${imageName}/', [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], '${tifFile}', 'jpg', false);"

    dotAnnotationSize=30
    tifFile="${tifPath}/${imageName%.*}_AnnotatedBigDot.tif"

    matlabBigDotCommands="WriteAnnotations('${imageName}', '${cellClassificationCSVPath}', '${tilePath}', '${bigDotTilePath}', '${labelFile}', ${dotAnnotationSize}); Tiles2TIF('${bigDotTilePath}/${imageName}/', [${tileWidth} ${tileHeight}], [${imageWidth}, ${imageHeight}], '${tifFile}', 'jpg', false);"

    matlabMergeCSVCommands="MergeCSVs('${cellClassificationCSVPath}/${imageName}', '${tilePath}/${imageName}', '${mergedCSVPath}/${imageName%.*}.csv');"

    matlabMakeThumbnailCommands="makeThumbnails('$(dirname "$tifPath")', '$(basename "$tifFile")', '$(basename "$tifPath")', 'thumbnails');"

    matlab -nodesktop -nosplash -r "${matlabOpeningCommands} ${matlabSmallDotCommands} ${matlabBigDotCommands} ${matlabMergeCSVCommands}, ${matlabMakeThumbnailCommands} exit;"
done
