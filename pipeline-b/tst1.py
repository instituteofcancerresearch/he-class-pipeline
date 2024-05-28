import tensorflow as tf
import os
import datetime

print('Num GPUs Available: ',len(tf.config.experimental.list_physical_devices('GPU')))
print('Tensorflow version: ',tf.__version__)

if os.path.exists('/data/'):
    print('data folder exists')
    with open('/data/gpu-log.txt','a') as f:        
        f.write(f'{datetime.datetime.now()}\n')
        f.write(f'Num GPUs Available: {len(tf.config.experimental.list_physical_devices("GPU"))}\n')
        f.write(f'Tensorflow version: ,{tf.__version__}\n')
        f.write('-----------------------------------\n')
else:
    print('data folder does not exist')
    