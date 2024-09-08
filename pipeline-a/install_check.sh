source ~/.bashrc

singularity_path=$1

echo "Singularity path: $singularity_path"

# concat file path with file
singularity_path_check="$singularity_path/HEA.sif"

# Check the existence of a file
if [ -f $singularity_path_check ]; then
    echo "Singularity file exists: $singularity_path_check"
else
    echo "Singularity file does not exist: $singularity_path_check"
fi

return 0