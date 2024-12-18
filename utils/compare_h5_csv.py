import h5py
import numpy as np
import pandas as pd

def compare_h5(data_path_1, data_path_2):

    h5_file_1 = h5py.File(data_path_1, 'r')
    h5_file_2 = h5py.File(data_path_2, 'r')

    flag = True

    groups_1 = list(h5_file_1.keys())
    groups_2 = list(h5_file_2.keys())

    if groups_1 == groups_2:
        for group_1 in groups_1:
            datasets_1 = list(h5_file_1[group_1].items())
            datasets_2 = list(h5_file_2[group_1].items())

        if datasets_1 == datasets_2:
            for (dataset_1_name, dataset_1), (dataset_2_name, dataset_2) in zip(datasets_1, datasets_2):
                if dataset_1_name == dataset_2_name and dataset_1.shape == dataset_2.shape:
                    if not np.array_equal(dataset_1[:], dataset_2[:]):
                        flag = False
                        break
                else:
                    flag = False
                    break   
        else:
            flag = False
    else:
        flag = False

    if flag:
        print("Data files are the same.")

    else:
        print("Data files are not the same.")

def compare_csv(data_path_1, data_path_2):
    df1 = pd.read_csv(data_path_1)
    df2 = pd.read_csv(data_path_2)

    if df1.equals(df2):
        print("Data files are the same.")
    else:
        print("Data files are not the same.")

