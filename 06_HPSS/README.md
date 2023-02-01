## Explanation HPSS

### ECMWF's HPSS is called ECFS
ECMWF's HPSS (high performance storage system) is called ECFS. This is tape storage. 
First we have to make a folder structure on ECFS to save the cmorized data into: `01_make_ec_folders.sh`
This is done once per time slice (hxxx = PD and sxxx = +2K). 

Bringing these files to the ECFS is done as a batch job by calling the script `02a_cmor_by_freq_to_ECFS.sh`
from `02b_submit-cmor_to_ECFS-freq-exp.sh` with the necessary arguments. Run this script without arguments for examples how to call this script.
