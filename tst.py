import sys; 
sys.path.append('/data/scratch/shared/SINGULARITY-DOWNLOAD/RSE/he-class-pipeline/pipeline-d/code/cell_classifier/classification');     
import processCSVs;
processCSVs.processCSVs(imagePath='SS-05-14545-1A.ndpi',     
                        detectionPath='/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outD1/20180117/csv',     
                        tilePath='/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outA',
                        classifierPath='/data/scratch/DMP/UCEC/GENEVOD/ntrahearn/Models/CellClassification/EPICC/NDPI/Current/EPICC_Cell_Classifier_NDPI.h5',     outPath='/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outD2/csv', segmentPath='/data/scratch/DCO/DIGOPS/SCIENCOM/ralcraft/he-classifier-dev/outB',     batchSize='50', outLabels='['nep', 'unk', 'myo', 'cep', 'fib', 'lym', 'neu', 'mac', 'end']',    
                        minProb='0.0', 
                        noClassLabel='1',     
                        outputProbs='False', overwrite='False');