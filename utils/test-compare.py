from PIL import Image
import numpy as np
import cv2
# image_similarity_measures taken from: https://github.com/nekhtiari/image-similarity-measures
from image_similarity_measures.quality_metrics import rmse, sre

def compare_images(path_1, path_2):
    """
        Description:
        Function which compares images to each other thourgh comparing their numpy arrays.
        If the images are differnt, difference metrics are displayed. 

        Metric:
        RMSE - measures the amount of change per pixel due to the processing.

    """
    step_lit_reg = ['outA-Tiles', 'outB-Masks', 'outC-Norm']
    step_lit_test = ['outA', 'outB', 'outC']
    folder_list = ['SS-05-14545-1A', 'SS-05-21490-1A', 'SS-08-12230-3A', 'SS-08-12436-1A', 'SS-09-24500-2A']
    # valid_extensions = ['.jpg', '.png']

    for step in range(len(step_lit_reg)):
        count = 0
        print(f"Analysing step {step_lit_test[step]}")
        folder_path1 = path_1 + step_lit_reg[step]
        folder_path2 = path_2 + step_lit_test[step]

        for folder in folder_list:
            folder_name = (f'{folder}.ndpi')
            print(f"In folder {step_lit_test[step]}/{folder_name}")

            for i in range(0, 35):
                image1_base = f'{folder_path1+"/"+folder_name}/Da{i}'
                image2_base = f'{folder_path2+"/"+folder_name}/Da{i}'

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

                    except FileNotFoundError as e:
                        # print(f"Error opening images Da{i} with {ext} extension: {e}")
                        continue
                # else:
                #     print(f"Da{i}: No image file found with .jpg or .png extensions.")

            print(f"{count} different images in folder {folder}")

# Change paths by specifying where your data is:
## path1 - analysed test data directory
## path2 - test data directory you have analysed with updated pipeline

# path1 = "path/to/data/he-class-pipeline/regression/"
# path2 = "path/to/data/HE_test/"

path1 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/"
path2 = "/Users/ashcherbakova/Desktop/HE_test/"

compare_images(path1, path2)