from PIL import Image
import numpy as np
import cv2
# image_similarity_measures taken from: https://github.com/nekhtiari/image-similarity-measures
from image_similarity_measures.quality_metrics import rmse, sre
import glob
import sys
import os

path1 = sys.argv[1]
path2 = sys.argv[2]
recursive = sys.argv[3]

def compare_images(path_new, path_regression, recursive):
    """
        Description:
        Function which compares images to each other thourgh comparing their numpy arrays.
        If the images are differnt, difference metrics are displayed. 

        Metric:
        RMSE - measures the amount of change per pixel due to the processing.

    """
    print("---------- Image Compare Utility ----------")
    print(f"Regression: {path_regression}")
    print(f"New test: {path_new}")

    if recursive == "Y":
        folder_list1 = sorted(glob.glob(path_regression+"/out*"))
        folder_list2 = sorted(glob.glob(path_new+"/out*"))        
        if folder_list1 == [] or folder_list2 == []:
            raise FileNotFoundError
    else:
        folder_list1 = [path_regression]
        folder_list2 = [path_new]
            
    total_count = 0
    total_missing = 0
    for folder1, folder2 in zip(folder_list1, folder_list2):
        subfolder_list1 = sorted(glob.glob(folder1+"/*.ndpi"))
        subfolder_list2 = sorted(glob.glob(folder2+"/*.ndpi"))
        
        name_list1 = []
        for subfolder in subfolder_list1:
            name_list1.append(os.path.basename(subfolder))
            
        name_list2 = []
        for subfolder in subfolder_list2:
            name_list2.append(os.path.basename(subfolder))
            
        print(f"Regression images: {name_list1}")
        print(f"Test images: {name_list2}")
                
        for image_name in name_list1:
            subfolder1 = folder1 + "/" + image_name
            subfolder2 = folder2 + "/" + image_name
            print(f"Compare folders {subfolder1} {subfolder2}")
            files_1tmp = sorted(glob.glob(subfolder1+"/Da*"))
            files_2tmp = sorted(glob.glob(subfolder2+"/Da*"))            
            files_1 = []
            files_2 = []            
            for file in files_1tmp:
                files_1.append(os.path.basename(file))
            for file in files_2tmp:
                files_2.append(os.path.basename(file))
                                                                            
            count = 0
            for file in files_1:
                image1_path = f'{subfolder1}/{file}'
                image2_path = f'{subfolder2}/{file}'
                
                #print(f"Compare images {image1_path} {image2_path}")
                
                if not os.path.isfile(image2_path):
                    total_missing += 1
                    print(f"Missing file: {image2_path}")                                                                                                    
                else:
                    try:
                        image1 = Image.open(image1_path)                        
                        image2 = Image.open(image2_path)                                        
                        image1_array = np.array(image1)
                        image2_array = np.array(image2)

                        if np.array_equal(image1_array, image2_array) == False:
                            count += 1                            
                            print(f"{file}: The images are different.")
                            image1_cv2 = cv2.imread(image1_path)
                            image2_cv2 = cv2.imread(image2_path)
                            out_rmse = rmse(image1_cv2, image2_cv2)
                            # out_sre = sre(image1_cv2, image2_cv2)
                            print(f"RMSE image difference: {out_rmse}")
                            # print(f"SRE image difference: {out_sre}")
                                                
                    except FileNotFoundError as e: 
                        print(f"File not found: {e}")                                               
                        continue
                
            print(f"--- {count} different images in folder found")
            total_count += count
    print(f"Total differences in all folders: {total_count}")
    print(f"Total missing in compare folder: {total_missing}")

compare_images(path1, path2, recursive)