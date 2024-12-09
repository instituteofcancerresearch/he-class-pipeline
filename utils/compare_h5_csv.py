import h5py
import numpy as np
import pandas as pd

def compare_h5(data_path_1, data_path_2, key_in = "ALL"):

    
    with h5py.File(data_path_1, 'r') as h5_file_1, h5py.File(data_path_2, 'r') as h5_file_2:
    
        num_diff = 0
        num_records = 0
        
        groups_1 = list(h5_file_1.keys())
        groups_2 = list(h5_file_2.keys())
                                
        if groups_1 != groups_2:
            num_diff = 1
            print(f"Groups are different {groups_1} {groups_2}")
        else:
            for key1 in groups_1:        
                if key_in == "ALL" or key1.upper() == key_in.upper():
                    datasets_1 = list(h5_file_1[key1].items())
                    datasets_2 = list(h5_file_2[key1].items())
                                                            
                    if datasets_1 != datasets_2:                    
                        print(f"Datasets are different: KEY={key1}")
                        #print(f"{datasets_1}")
                        #print(f"{datasets_2}")
                        
                    
                    for (dataset_1_name, dataset_1), (dataset_2_name, dataset_2) in zip(datasets_1, datasets_2):
                        #print(f"Compare datasets {dataset_1_name} {dataset_2_name}")
                        if dataset_1_name == dataset_2_name and dataset_1.shape == dataset_2.shape:
                            num_records += 1                            
                            if not np.array_equal(dataset_1[:], dataset_2[:]):
                                #for i in range(dataset_1.shape[0]):
                                #    if not np.array_equal(dataset_1[i], dataset_2[i]):
                                #        print(f"{dataset_1[i]}, {dataset_2[i]}")
                                num_diff += 1
                                print(f"Dataset {dataset_1_name} is different")
                                
                                                            
        return num_records, num_diff

def compare_csv(data_path_1, data_path_2):
    are_the_same = True
    df1 = pd.read_csv(data_path_1)
    df2 = pd.read_csv(data_path_2)

    if df1.equals(df2):
        are_the_same = True
    else:
        are_the_same = False
    return are_the_same
