import cv2
import glob
import numpy as np
import os

def get_cws_lab_stats(cws_path, mask_path=None, file_pattern='Da*.jpg'):
    if mask_path == '':
        mask_path = None
    print("",end="\n")
    print("get_cws_lab_stats", cws_path, mask_path, file_pattern)
    files = glob.glob(os.path.join(cws_path, file_pattern))
    
    hists = np.zeros((256, 3), dtype=np.int64)
    
                            
    for file in files:
        file_name = os.path.basename(file)
        print("file_name", file_name,end="\t")
        
        #RSA todo what does this mean?
        if mask_path is None or os.path.isfile(os.path.join(mask_path, file_name[:-3]+'png')):            
            if ".err" in file_name:
                continue
            if ".out" in file_name:
                continue
            if ".txt" in file_name:
                continue
            print("...processing", file_name)
            im = cv2.imread(file)

            lab = cv2.cvtColor(im, cv2.COLOR_BGR2Lab)
            lab = np.reshape(lab, (-1, 3))
            
            mask = cv2.imread(os.path.join(mask_path, file_name[:-3]+'png'), cv2.IMREAD_GRAYSCALE)
            mask = np.reshape(mask, (-1, ))
            hists[:, 0] += np.histogram(lab[mask>0, 0], bins=range(257))[0]
            hists[:, 1] += np.histogram(lab[mask>0, 1], bins=range(257))[0]
            hists[:, 2] += np.histogram(lab[mask>0, 2], bins=range(257))[0]
    
    pixels = np.sum(hists, axis=0)
    values = np.tile(np.array(range(256))[:, np.newaxis], (1, 3))
    
    means = np.sum(hists*values, axis=0)/pixels
    stds = (np.sum(hists*((values-means)**2), axis=0)/pixels)**0.5
    
    return (means, stds)
