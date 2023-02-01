##  Explanation cmorization tool

### Purpose 
Purpose is to cmorize all variables raw ECE3 output following CMIP6 data format convention. The available variables are listed in the file request-overview-CMIP-historical-including-EC-EARTH-AOGCM-preferences.txt  The text files gives an overview of variables available per output frequency. The output frequencies are: AERmon, Amon, Emon, LImon, Lmon, Ofx, Omon, SImon, fx, Eday, Oday, day, CFday, 3hr, 6hrPlev, 6hrPlevPt. Further details on the variables and their output dimensions is available via the following search tool: [CMIP6 Data Request; MIP Variables -- search](https://clipc-services.ceda.ac.uk/dreq/mipVars.html)

Cmorization of ECE3 data depends on:
- varlist `JSON` file
- metadata `JSON` file
- ece2cmor package [https://github.com/EC-Earth/ece2cmor3](https://github.com/EC-Earth/ece2cmor3) 

### Use

Run the script `run_ece2cmor.sh` for a given ensemble member. This generates two bash scripts (one for IFS and one for NEMO) describing the batch job via calling `submitVAREX-at-cca-ece2cmor-leg-job.sh`. 
Run the generated scripts to submit. An example (for IFS) is `cmorise-s110-ifs-001.sh`.

### Issues

It turns out, the cmorization of the IFS part requires vastly more memory than the cmorization of NEMO. 
- `NEMO: EC_memory_per_task=100mb`
- `IFS: EC_memory_per_task=60GB`
Make sure to take this into consideration before submitting the job. For future cmorization jobs it will be best to rewrite the script to incorporate this. 