# VAREX-LE production tools

## Sections

1. Preprocessing

2. Compiling

3. Running

4. Postprocessing 

5. Validation
Purpose of the validation is to check the cmorization output. 
If there were any problems with the raw EC-Earth run, it will show up by consequence. 
Further it performs a checksum and an nctime. 
Also it rewrites the datestamp on the cmor files to 01/06/2022, such that all have the same name. 

6. HPSS 
ECMWF's HPSS (high performance storage system) is called ECFS. This is where the ensemble (cmorized output) is stored. 

7. ECtrans
ECtrans is unattended file transfer between the ECMWF servers and the member state servers. This is helpfull for transferring large amounts of data from the ECFS tape storage. 

