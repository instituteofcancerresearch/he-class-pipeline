import cv2
import glob
import numpy as np
import os
import shutil
from .get_cws_lab_stats import get_cws_lab_stats
import datetime

def norm_cws_by_stats(source_path, out_path, source_stats, target_stats, mask_path=None, file_pattern='Da*.jpg'):
    try:        
        os.makedirs(out_path, exist_ok=True)
    except Exception as e:
        print("Error making dir",str(e))
    
    
    files = glob.glob(os.path.join(source_path, file_pattern))
                        
    for file in files:
        file_name = os.path.basename(file)        
                
        if mask_path is None or os.path.isfile(os.path.join(mask_path, file_name[:-3]+'png')):
            im = cv2.imread(file)
            lab = cv2.cvtColor(im, cv2.COLOR_BGR2Lab)
            lab = np.reshape(lab, (-1, 3)).astype(np.double)

            mask = cv2.imread(os.path.join(mask_path, file_name[:-3]+'png'), cv2.IMREAD_GRAYSCALE)
            mask = np.reshape(mask, (-1, ))
            
            lab[mask>0, :] = (((lab[mask>0, :]-source_stats[0])/source_stats[1])*target_stats[1])+target_stats[0]
            lab[lab<0] = 0
            lab[lab>255] = 255
            lab = np.reshape(lab, im.shape).astype(np.uint8)
            
            norm = cv2.cvtColor(lab, cv2.COLOR_Lab2BGR)
            cv2.imwrite(os.path.join(out_path, file_name), norm)
        else:
            shutil.copyfile(file, os.path.join(out_path, file_name))
            
            
def norm_cws_by_stats_batch(cws_path, target_path, out_path, cws_mask_path=None, target_mask_path=None, file_pattern='Da*.jpg'):
    
    target_stats = get_cws_lab_stats(target_path, mask_path=target_mask_path)
    
    folders = glob.glob(os.path.join(cws_path, '*'))
    
    output_log = f"{out_path}/p-log.txt"
        
    for source_path in folders:
        folder_name = os.path.basename(source_path)
        source_mask_path = os.path.join(cws_mask_path, folder_name)
        norm_path = os.path.join(out_path, folder_name)
        # if not os.path.isdir(norm_path):
        if os.path.exists(output_log):
            with open(output_log, "a") as f:
                f.write(f"\t{datetime.datetime.now()}\tProcessing {source_path}\n")
                
        source_stats = get_cws_lab_stats(source_path, mask_path=source_mask_path)

        norm_cws_by_stats(source_path, norm_path, source_stats, target_stats, mask_path=source_mask_path, file_pattern=file_pattern)
