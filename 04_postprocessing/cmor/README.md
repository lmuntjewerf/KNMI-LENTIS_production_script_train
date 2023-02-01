##  Explanation cmorization tool

### Purpose 
Purpose is to cmorize all variables raw ECE3 output following CMIP6 data format convention. The available variables are listed in the file request-overview-CMIP-historical-including-EC-EARTH-AOGCM-preferences.txt  The text files gives an overview of variables available per output frequency. The output frequencies are: AERmon, Amon, Emon, LImon, Lmon, Ofx, Omon, SImon, fx, Eday, Oday, day, CFday, 3hr, 6hrPlev, 6hrPlevPt. Further details on the variables and their output dimensions is available via the following search tool: [CMIP6 Data Request; MIP Variables -- search](https://clipc-services.ceda.ac.uk/dreq/mipVars.html)

### Use

Run the script `run_ece2cmor.sh` for a given ensemble member. This generates two bash scripts (one for IFS and one for NEMO) describing the batch job. Run to submit. 

### Issues