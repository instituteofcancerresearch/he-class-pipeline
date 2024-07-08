
### Resources
- [Openslider installation](https://openslide.org/download/)  


Run singularity locally:
```bash
singularity run -B ../in-a:/input -B ../out-a:/output docker://icrsc/he-class-slide ./data ./output Y Y *.ndpi
```
Run python locally:



Run remotely
ssh ralcraft@alma.icr.ac.uk