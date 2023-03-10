##  Explanation validation tool

### Purpose 
Purpose of the validation is to check the cmorization. 
If there were any problems with the raw EC-Earth run, it will show up by consequence. 
Further it performs a checksum and an nctime. 
Also it rewrites the datestamp on the cmor files to 01/06/2022, such that all have the same name. 

### Use
Using the validation tool takes 3 steps: 
1) make the validation scripts
`for run in h017 h018 h019; do ./validate-varex-simulations.sh $run ; done `
2) execute validation script #1 (example provided in this folder is `validate-varex-simulation-h100_1.sh`)
This is the main body of work. It checks whether all legs of the cmorization are done and counts a number of files.
Also it submits the checksum and nctime jobs.
It is handy to start this in a screen session (screen -S) because it takes a while)
3) after the jobs have finished, you can execute validation script #2 (example provided in this folder is `validate-varex-simulation-h100_2.sh`). This does checks and return error messages if something is missing. 
This takes very short, best done on the commad line. 

### Checks and Output
1) validation script #1 
The output should look like: 

```
10
10
18
18
The cmorise-h021-ifs-001.sh job has finished.
The cmorise-h021-ifs-002.sh job has finished.
The cmorise-h021-ifs-003.sh job has finished.
The cmorise-h021-ifs-004.sh job has finished.
The cmorise-h021-ifs-005.sh job has finished.
The cmorise-h021-ifs-006.sh job has finished.
The cmorise-h021-ifs-007.sh job has finished.
The cmorise-h021-ifs-008.sh job has finished.
The cmorise-h021-ifs-009.sh job has finished.
The cmorise-h021-ifs-010.sh job has finished.
The cmorise-h021-nemo-001.sh job has finished.
The cmorise-h021-nemo-002.sh job has finished.
The cmorise-h021-nemo-003.sh job has finished.
The cmorise-h021-nemo-004.sh job has finished.
The cmorise-h021-nemo-005.sh job has finished.
The cmorise-h021-nemo-006.sh job has finished.
The cmorise-h021-nemo-007.sh job has finished.
The cmorise-h021-nemo-008.sh job has finished.
The cmorise-h021-nemo-009.sh job has finished.
The cmorise-h021-nemo-010.sh job has finished.
20
```

2) validation script #2 does checks: 
Output on screen should read this

```
Number of node(s): 1660
Number of dataset(s): 166
Number of dataset(s) with overlap(s): 0
Number of dataset(s) with broken time series: 0
Number of file(s) scanned: 1660
Number of file(s) skipped: 0
```

### Issues
An earlier version of the script would alther the permissions of folders after it changed the datestamp folder name. 
This now leads to problems because owners don't have permissions on some parts of the LENTIS dataset. 
The current work-about is to perform the following (after the untar action on the tar-zipped download files): 
- chmod -R u+r+w <your_folder> 

An error that unfortunately arose, is with the 100m wind variables. 
These are not produced. 
The message looks like this: 
```
h021-ifs-010-20220623123303.log:2022-06-23 12:33:16 ERROR:ece2cmor3.grib_filter: Field missing in the first day of file: code 246.228, level type 105, level 100. Dismissing task ua100m in table 6hrPlev
h021-ifs-010-20220623123303.log:2022-06-23 12:33:16 ERROR:ece2cmor3.grib_filter: Field missing in the first day of file: code 247.228, level type 105, level 100. Dismissing task va100m in table 6hrPlev
```

Another issue is with the reprocessing of the 1st part of LENTIS. This returns an error from nemo, 
It looks like this: 
```
h021-nemo-010-20220623084239.log:2022-06-23 08:42:40 ERROR:ece2cmor3.nemo2cmor: Could not use bathymetry file for variable deptho in table Ofx: task skipped.
h021-nemo-010-20220623084239.log:2022-06-23 08:42:40 ERROR:ece2cmor3.nemo2cmor: Could not use subbasin file for variable basin in table Ofx: task skipped.
```


