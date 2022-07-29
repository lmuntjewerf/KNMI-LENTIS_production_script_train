#!/bin/bash
shopt -s expand_aliases # to make aliasses work in a bash script
source ~/.user_bashrc

 cat ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/h086/nct*
 grep -e broken -e overlap -e error ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/h086/nct* |sed -e 's/^.*log-nctcck.//' -e 's/.nct..k-.*log:/: /'
 ls -ld /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-h086/h086/CMIP6//../
