## Setting up the IC folder structure

To organise the production of this LENTIS, we generate job submit folders for each ensemble member (each run) individually, with their respective settings. This helps to keep an overview of the 320 runs in this ensemble. Also, this helps to track the runs and trace back when a run fails and need to be resubmitted. 

Large Ensemble preparations for running the simulations: 
- Generatate a folder structure with run submit folder for each individual ensemble member
- Add in some extra/external scripts to all these folders later

### 1. Making the first submit folder h010
First we make 1 submit folder. We need to copy in come HPC machine specific files, namely those in the folder `00_scripts_to_add_in`
Once that is done, this folder is used as a template for all other folders in step 2. 

### 2. Making all the submit folders
The submit folders are made with the script `01_make_all_submit_folders.sh`. This script rsyncs the first submit folder that was made in step 1. Then calls the script `set-ensemble-member-changes.sh`, which is part of the model branch code, which automates making all the changes that are specific to the respective ensemble member. 

In case of updates to the model branch, the script `02_svn_update_all_submit_folders.sh` can be used to update all submit folders. 