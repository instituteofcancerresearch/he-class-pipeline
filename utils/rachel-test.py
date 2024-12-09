
#mamba create -n he-compare-images -c conda-forge python=3.10 numpy pillow pyfftw
#mamba activate he-compare-images
#mamba install pandas
#python -m pip install opencv-python
#python -m pip install image-similarity-measures
#python -m pip install h5py
#mamba deactivate

#python utils/rachel-test.py

###!!! Be aware of the error of you mispell the path #############
# Unable to synchronously open file (una
###################################################################

from compare_h5_csv import compare_h5, compare_csv

if True:
    h5_path_1 = "rDa6.h5"
    h5_path_2 = "sDa6.h5"
    compare_h5(h5_path_1, h5_path_2,"ALL")
    #compare_h5(h5_path_1, h5_path_2,"feat")
    #compare_h5(h5_path_1, h5_path_2,"output")

if False:
    csv_path_1 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da6.csv"
    csv_path_2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da16.csv"
    compare_csv(csv_path_1, csv_path_2)