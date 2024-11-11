## need to first install the requirements form the requirements.txt
from PIL import Image
import numpy as np
import cv2
# image_similarity_measures taken from: https://github.com/nekhtiari/image-similarity-measures
from image_similarity_measures.quality_metrics import rmse, sre
import os
import glob

def compare_images(path_1, path_2):
    """
        Description:
        Function which compares images to each other thourgh comparing their numpy arrays.
        If the images are differnt, difference metrics are displayed. 

        Metric:
        RMSE - measures the amount of change per pixel due to the processing.

    """

    folder_list1 = sorted(glob.glob(path_1+"/out*"))
    folder_list2 = sorted(glob.glob(path_2+"/out*"))
    # print(folder_list1)
    # print(folder_list2)
    for folder1, folder2 in zip(folder_list1, folder_list2):
        subfolder_list1 = sorted(glob.glob(folder1+"/*.ndpi"))
        subfolder_list2 = sorted(glob.glob(folder2+"/*.ndpi"))
        # print(subfolder_list1)
        # print(subfolder_list2)
        for subfolder1, subfolder2 in zip(subfolder_list1, subfolder_list2):
            print(f"In folder {subfolder1}")
            file_num1 = len(glob.glob(subfolder1+"/Da*"))
            file_num2 = len(glob.glob(subfolder2+"/Da*"))

            for i in range(0, (file_num1 + 1)):
                count = 0
                image1_base = f'{subfolder1}/Da{i}'
                image2_base = f'{subfolder2}/Da{i}'

                for ext in ['.jpg', '.png']:
                    try:
                        image1_path = (f'{image1_base}{ext}')
                        image2_path = (f'{image2_base}{ext}')
                        # print(image1_path)
                        # print(image2_path)
                        
                        image1 = Image.open(image1_path)
                        image2 = Image.open(image2_path)
                        
                        image1_array = np.array(image1)
                        image2_array = np.array(image2)

                        if np.array_equal(image1_array, image2_array) == False:
                            count += 1
                            print(f"Da{i}: The images are different.")
                            image1_cv2 = cv2.imread(image1_path)
                            image2_cv2 = cv2.imread(image2_path)
                            out_rmse = rmse(image1_cv2, image2_cv2)
                            # out_sre = sre(image1_cv2, image2_cv2)
                            print(f"RMSE image difference: {out_rmse}")
                            # print(f"SRE image difference: {out_sre}")
                        
                        # else:
                        #     print(f"Da{i}: The images are the same.")

                    except FileNotFoundError:
                        continue
                    except Exception as e:
                        print(f"Error opening images Da{i} with {ext} extension: {e}")
                        continue
                # else:
                #     print(f"Da{i}: No image file found with .jpg or .png extensions.")

            # print(f"{count} different images in folder {folder}")

# Change paths to the folders with images you want to compare, folders have to have the same 
# names for files that are being compared
path1 = "/Users/ashcherbakova/Desktop/HE_test"
path2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression"

compare_images(path1, path2)