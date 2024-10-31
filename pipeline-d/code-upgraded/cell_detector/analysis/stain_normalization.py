import matlab.engine
import sys
import os

#https://mscipio.github.io/post/matlab-from-python/

sub_dir_name = sys.argv[1]
print(sub_dir_name)
eng = matlab.engine.start_matlab()
eng.eval('run initialize_matlab_variables.m', nargout=0)
matlab_input = {'input_path': os.getcwd(),
                'feat': ['h', 'rgb'],
                'output_path': os.path.join(os.getcwd(), 'output_path'),
                'sub_dir_name': sub_dir_name,
                'tissue_segment_dir': os.path.join(os.getcwd(), 'output_path')}
eng.workspace['matlab_input'] = matlab_input

#matlab_input.output_path
#matlab_input.sub_dir_name
#matlab_input.tissue_segment_dir
#matlab_input.input_path
#matlab_input.feat
#matlab_input.curr_norm_methods

for mli in matlab_input:
    print("Matlab intended input =", mli, matlab_input[mli])

#eng.eval('run pre_process_images.m', nargout=0)


print("Running some matlab code:")
# variable x in Python workspace
x = 4.0
# a new variable called y is added to MATLAB workspace, and is value is set to be equal to Python's x
eng.workspace['y'] = x
# we can use variable y while calling MATLAB functions, ad MATLAB is aware of all the variable availabe in its workspace
a = eng.eval('sqrt(y)')
print("Called matlab",a)
