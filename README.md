# This is the H&E Image Classifier pipeline

The pipeline has been taken from Nick Trahearn's code and adapted to work with the ICR H&E Image Classifier web-app.

A version of the cell classifier can be found here:
https://github.com/sottorivalab/FORECAST_cell_classification

Within this repo, you can find the bash script containing the key parameters is here:
https://github.com/sottorivalab/FORECAST_cell_classification/blob/main/code/run_cell_classifier.sh

Before classification, there are a few of pre-processing steps you have to run. The code for those can be found here:
https://github.com/sottorivalab/FORECAST_image_tiling


#Moving or copying Nick's conda environments
To move or copy Nick's conda environments, you can use the following command:
```bash
cp -r /data/scratch/DMP/UCEC/GENEVOD/ntrahearn/.conda/envs/openslide-mod /data/scratch/shared/RSE/.conda/envs/openslide-mod

```

