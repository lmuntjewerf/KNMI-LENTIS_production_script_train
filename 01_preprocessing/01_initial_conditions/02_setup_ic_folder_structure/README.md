## Setting up the IC folder structure

To run an ensemble where each members has an unique combination of IC files but without copying these IC files redundantly, we set up a softlink file structure to link the correct IC files to the correct LENTIS member.  

The scripts in this folder serve two purposes: 
- organise the parent IC files and tailor the folder structure to our needs
- set up a framework that softlinks/symlinks the unperturbed IC files to the right ensemble member

### 01 Untar parent IC files

Two shell scripts for untarring the IC files from the parents and save the contents in the right folders for running the ensemble. 

### 02 Make symlink folders

For each unique LENTIS member we make a folder with IC files. 
This is done in `02a_make_all_ic_files_folders.sh`. 

The IC files to symlink into these folders are: 
- OASIS (coupler)
- IFS (atmosphere component)
- NEMO (ocean component)

The parent OASIS and NEMO IC files don't undergo micro perturbations. For all 10 ensemble members with the same parent, the OASIS and NEMO IC files are identical. That means, we softlink each set of IC files from OASIS and NEMO to 10 ensemble member ic-folders. 
The parent OASIS IC files are softlinked in `02a_make_all_ic_files_folders.sh`. 
The parent NEMO IC files are softlinked in `02b_symlink_all_nemo_restarts.sh`.

Each ensemble member has a unique set of IFS IC files. 
A part of the parent IFS IC files don't undergo micro perturbations and we need to softlink these for each parent to 10 ensemble member ic-folders. Another part of the parent IFS IC files _do_ undergo micro perturbations (in `01_generate_perturbed_ics`): these are the `ICMSHxxxx` IC files. Each ensemble member has a unique `ICMSHxxxx` IC file. 

The softlinking of the parent IFS ICs is done in `02c_symlink_all_IFS_icfiles.sh`
We need to remove the redundant unperturbed `ICMSHxxxx` IC files that got copied with this script. This is done in `02d_rm_redundant_IFS_ICMSH_symlinks.sh`. 
**CHECK hoe dit zit!!** Next, the perturbed `ICMSHxxxx` IC files need to be softlinked in 
Finally, we rename some ic files in `02e_rename_some_ic_files.sh`

### 03 Checks

These scripts count the amount of IC files for NEMO and IFS for each ensemble member. IFS should have 10 softlinks and NEMO should have 560 softlinks (for this particular processor layout)


### 04 Remove symlink folders (if something went wrong)

Loop to remove (part of) the ic folders