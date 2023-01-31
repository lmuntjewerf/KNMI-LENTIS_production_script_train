## Explanation HPSS

### ECMWF's HPSS is called ECFS
ECMWF's HPSS (high performance storage system) is called ECFS. This is tape storage. 
First we have to make a folder structure on ECFS to save the cmorized data into: `01_make_ec_folders.sh`
This is done once per time slice (hxxx = PD and sxxx = +2K). 

Bringing these files to the ECFS can be done in two waus: 
- on the command line (that's not always feasible as these jobs take very long): `02a_cmor_by_freq_to_ECFS.sh`
- as a submitted job `02b_submit-cmor_to_ECFS-freq-exp.sh`
