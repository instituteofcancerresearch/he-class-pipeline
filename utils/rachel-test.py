
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
    # COmparing pre-processing files
    print("--- Comparing 1 and 2 ---)")
    h5_path_1 = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_1.h5"
    h5_path_2 = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_2.h5"
    res = compare_h5(h5_path_1, h5_path_2,"ALL")
    print(res)
    
    print("--- Comparing 01 and 02 ---)")
    h5_path_03 = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_01.h5"
    h5_path_04 = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_02.h5"
    res = compare_h5(h5_path_03, h5_path_04,"ALL")
    print(res)
    
    print("--- Comparing 02 and 03 ---)")
    h5_path_03 = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_03.h5"    
    res = compare_h5(h5_path_03, h5_path_04,"ALL")
    print(res)
    
    print("--- Comparing 03 and 04 ---)")    
    h5_path_04 = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_03.h5"
    res = compare_h5(h5_path_03, h5_path_04,"ALL")
    print(res)
    
    print("--- Comparing 03 and Nick ---)")
    h5_path_n = "/home/ralcraft/dev/shiny-proxy-developed/he-classifier/he-class-pipeline/utils/pp/Da6_n.h5"    
    res = compare_h5(h5_path_03, h5_path_n,"ALL")        
    print(res)
    
    print("--- Comparing 04 and Nick ---)")
    res = compare_h5(h5_path_04, h5_path_n,"ALL")
    print(res)
    

if False:
    csv_path_1 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da6.csv"
    csv_path_2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da16.csv"
    compare_csv(csv_path_1, csv_path_2)