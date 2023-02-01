# KNMI-LENTIS_production_script_train

These are the scrips used in the production of the KNMI-LENTIS (Large Ensemble Time Slice) dataset. The dataset is documented in this repository: [https://github.com/lmuntjewerf/KNMI-LENTIS_dataset_description](https://github.com/lmuntjewerf/KNMI-LENTIS_dataset_description) 

The Global Climate Model that is used for generating this Large Ensemble is EC-Earth3 - VAREX project branch [https://svn.ec-earth.org/ecearth3/branches/projects/varex](https://svn.ec-earth.org/ecearth3/branches/projects/varex) (access restricted to ECMWF members). 

## Sections

1. Preprocessing
Preprocessing in preparation for running the ensemble consists of: 
- generating initial condition files and setting up a framework to access them efficiently
- set up a framework of submit folders for each ensemble member

2. Compiling
This folder contains the wrapper to submit the compilation job for EC-Earth3 on ECMWF's HPC cca.

3. Running
All ensemble members have an own run directory as generated in [01_preprocessing/02_submit_folders]. The running folder, in operational state, contained softlinks to all these submit directories and a softlink to the EC-Earth3 code base. 
It further contains the wrapper template to sumbit the simulation (copy this file in the rundir/classic folder).

4. Postprocessing 
All raw EC-Earth3 output from the ensemble members is cmorized following CMIP6 data format convention. The scripts in this folder detail the cmorization process. 

5. Validation
Purpose of the validation is to check the cmorization output. 
If there were any problems with the raw EC-Earth run, it will show up by consequence. 
Further it performs a checksum and an nctime. 
Also it rewrites the datestamp on the cmor files to 01/06/2022, such that all have the same name. 

6. HPSS 
KNMI-LENTIS is stored at the high performance storage system of the ECMWF (ECFS). The scripts in this folder detail the storing process. 

7. ECtrans
ECtrans is unattended file transfer between the ECMWF servers and the member state servers. This is helpfull for transferring large amounts of data from the ECFS tape storage. 

