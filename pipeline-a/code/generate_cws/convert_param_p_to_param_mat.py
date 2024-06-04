import os
import glob
import pathlib
import pickle
import scipy.io as sio


if __name__ == '__main__':
    cws_dir = os.path.normpath(str(pathlib.Path(r'R:/tracerx/Melanoma/Quad/data/cws')))
    pattern = '*.ndpi/'

    wsi_file_list = sorted(glob.glob(os.path.join(cws_dir, pattern)))

    for wsi_n in range(0,len(wsi_file_list)):
        print('processing' + wsi_file_list[wsi_n] + '\n', flush=True)
        param = pickle.load(open(os.path.join(wsi_file_list[wsi_n], 'param.p'), 'rb'))
        sio.savemat(os.path.join(wsi_file_list[wsi_n], 'param.mat'), param)
