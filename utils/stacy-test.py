from compare_h5_csv import compare_h5, compare_csv

h5_path_1 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/h5/SS-05-14545-1A.ndpi/Da6.h5"
# h5_path_2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/h5/SS-05-14545-1A.ndpi/Da6.h5"
h5_path_2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/h5/SS-05-14545-1A.ndpi/Da17.h5"

compare_h5(h5_path_1, h5_path_2)

csv_path_1 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da6.csv"
csv_path_2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da16.csv"
# csv_path_2 = "/Users/ashcherbakova/Projects/he-class-pipeline/regression/outD1-Detection/20180117/csv/SS-05-14545-1A.ndpi/Da6.csv"

compare_csv(csv_path_1, csv_path_2)