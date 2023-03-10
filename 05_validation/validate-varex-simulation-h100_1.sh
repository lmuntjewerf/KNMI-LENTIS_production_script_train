
#!/bin/bash
shopt -s expand_aliases # to make aliasses work in a bash script
source ~/.user_bashrc


 # Validating the h100 cmorisation. Status =
 h100l; checkcmorised;
 ls -1l h100-nemo-*[0-9].cmor.log | wc -l; ls -1l h100-nemo-*[0-9].log | wc -l;
 ls -1l h100-ifs-*[0-9].cmor.log  | wc -l; ls -1l h100-ifs-*[0-9].log  | wc -l
 sse
 for i in `find $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//../../../..//pbs-log-for-cmorising-h100-*.out`; do sed -e '0,/--ececonf/d' -e '0,/sh.epilog.ecmwf-INFO/!d' -e '/sh.epilog.ecmwf-INFO/d' -e '/^$/d' ${i}; done
 for i in `find $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//../../../..//pbs-log-for-cmorising-h100-*.out`; do sed -e '0,/--ececonf/d' -e '0,/sh.epilog.ecmwf-INFO/!d' -e '/sh.epilog.ecmwf-INFO/d' -e '/^$/d' ${i}; done | wc -l
 mkdir -p filenumber-check
 ../data-qa/scripts/files-per-year.sh 2000 2009 $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/ > filenumber-check/filenumber-check-varex-simulations-h100.txt
 wc -l filenumber-check/filenumber-check-varex-simulations-h100.txt; grep 166 filenumber-check/filenumber-check-varex-simulations-h100.txt | wc -l
 ls -1 -d $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//CMIP/KNMI/EC-Earth3/historical/r1100i0p5f1//*/* | wc -l | grep -v -e 174
 find $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/ -empty
 find $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/ -type f ! -name '*.nc'
 find $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/ -name '*_r1100i0p5f1_g[rn][a-zA-Z0-9]*'
 ../data-qa/scripts/versions.sh -l $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/
 ../data-qa/scripts/versions.sh -v v20220601 -m $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/
 ../data-qa/scripts/versions.sh -l $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/
 for i in `find $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//CMIP/KNMI/EC-Earth3/historical/r1100i0p5f1/ -type d -name v20220601`; do ls -1 ${i} | wc -l | grep -v -e 10; done
 activateece2cmor3; sse
 ../data-qa/scripts/sftof.py $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//CMIP/KNMI/EC-Earth3/historical/r1100i0p5f1//Ofx/sftof/gn/v20220601/sftof_Ofx_EC-Earth3_historical_*_gn.nc
 rm -f $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//CMIP/KNMI/EC-Earth3/historical/r1100i0p5f1//Ofx/sftof/gn/v20220601/sftof_Ofx_EC-Earth3_historical_*_gn.nc.bak
 cd ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/
 ./submit-script-for-nctime-on-cca.sh   $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/ h100
 ./submit-script-for-checksum-on-cca.sh $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6/ h100



 more $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-h100/h100/CMIP6//../sha256sum-checksum-CMIP6-h100.txt | wc -l; more ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/h100/nct* | grep scanned
