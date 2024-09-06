# This wraps both processing scripts into a single script that can be called from the command line. It is used to process a single image.
import sys
file_path = sys.argv[1]
code_path = sys.argv[2]
print("Image to process=",file_path)
print("Code path=",code_path)

sys.path.append(code_path)


#imageWidth=$(sed -n 's/iWidth=//p' "${tilePath}/${imageName}/FinalScan.ini" | head -1)
#imageHeight=$(sed -n 's/iHeight=//p' "${tilePath}/${imageName}/FinalScan.ini" | head -1)
#tileWidth=$(sed -n 's/iImageWidth=//p' "${tilePath}/${imageName}/FinalScan.ini")
#tileHeight=$(sed -n 's/iImageHeight=//p' "${tilePath}/${imageName}/FinalScan.ini")

from code.cell_detector.analysis import Generate_Output

Generate_Output.Generate_Output(1, 2, 3, 4, 5, 6)

from code.cell_classifier..classification import processCSVs
processCSVs.processCSVs(1, 2, 3, 4, 5, segmentPath='6', batchSize=7, outLabels=8, minProb=9, noClassLabel=10, outputProbs=11)
