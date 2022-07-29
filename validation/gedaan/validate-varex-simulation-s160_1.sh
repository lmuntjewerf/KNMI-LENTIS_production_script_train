
#!/bin/bash
shopt -s expand_aliases # to make aliasses work in a bash script
source ~/.user_bashrc


 # Validating the s160 cmorisation. Status =
 s160l; checkcmorised;
 ls -1l s160-nemo-*[0-9].cmor.log | wc -l; ls -1l s160-nemo-*[0-9].log | wc -l;
 ls -1l s160-ifs-*[0-9].cmor.log  | wc -l; ls -1l s160-ifs-*[0-9].log  | wc -l
 sse
 for i in `find /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//../../../..//pbs-log-for-cmorising-s160-*.out`; do sed -e '0,/--ececonf/d' -e '0,/sh.epilog.ecmwf-INFO/!d' -e '/sh.epilog.ecmwf-INFO/d' -e '/^$/d' ${i}; done
 for i in `find /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//../../../..//pbs-log-for-cmorising-s160-*.out`; do sed -e '0,/--ececonf/d' -e '0,/sh.epilog.ecmwf-INFO/!d' -e '/sh.epilog.ecmwf-INFO/d' -e '/^$/d' ${i}; done | wc -l
 mkdir -p filenumber-check
 ../data-qa/scripts/files-per-year.sh 2075 2084 /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/ > filenumber-check/filenumber-check-varex-simulations-s160.txt
 wc -l filenumber-check/filenumber-check-varex-simulations-s160.txt; grep 166 filenumber-check/filenumber-check-varex-simulations-s160.txt | wc -l
 ls -1 -d /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//ScenarioMIP/KNMI/EC-Earth3/ssp245/r5160i0p5f1//*/* | wc -l | grep -v -e 174
 find /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/ -empty
 find /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/ -type f ! -name '*.nc'
 find /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/ -name '*_r5160i0p5f1_g[rn][a-zA-Z0-9]*'
 ../data-qa/scripts/versions.sh -l /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/
 ../data-qa/scripts/versions.sh -v v20220601 -m /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/
 ../data-qa/scripts/versions.sh -l /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/
 for i in `find /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//ScenarioMIP/KNMI/EC-Earth3/ssp245/r5160i0p5f1/ -type d -name v20220601`; do ls -1 ${i} | wc -l | grep -v -e 10; done
 activateece2cmor3; sse
 ../data-qa/scripts/sftof.py /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//ScenarioMIP/KNMI/EC-Earth3/ssp245/r5160i0p5f1//Ofx/sftof/gn/v20220601/sftof_Ofx_EC-Earth3_ssp245_*_gn.nc
 rm -f /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//ScenarioMIP/KNMI/EC-Earth3/ssp245/r5160i0p5f1//Ofx/sftof/gn/v20220601/sftof_Ofx_EC-Earth3_ssp245_*_gn.nc.bak
 cd ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/
 ./submit-script-for-nctime-on-cca.sh   /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/ s160
 ./submit-script-for-checksum-on-cca.sh /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6/ s160



 more /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s160/s160/CMIP6//../sha256sum-checksum-CMIP6-s160.txt | wc -l; more ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/s160/nct* | grep scanned
