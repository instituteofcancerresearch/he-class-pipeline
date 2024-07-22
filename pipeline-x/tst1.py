import tensorflow as tf
import os
import datetime
import sys

print('Num GPUs Available: ',len(tf.config.experimental.list_physical_devices('GPU')))
print('Tensorflow version: ',tf.__version__)
log_dir = sys.argv[1]
print('log_dir:',log_dir)
data_dir = sys.argv[2]
print('data_dir:',data_dir)

if os.path.exists(log_dir):
    print('data folder exists')
    with open('/heapplog/gpu-log.txt','a') as f:        
        f.write(f'{datetime.datetime.now()}\n')
        f.write(f'Num GPUs Available: {len(tf.config.experimental.list_physical_devices("GPU"))}\n')
        f.write(f'Tensorflow version: ,{tf.__version__}\n')
        f.write(f'log_dir: {log_dir}\n')
        f.write(f'data_dir: {data_dir}\n')
        f.write('-----------------------------------\n')
else:
    print('data folder does not exist')
    