#!/bin/bash
shopt -s expand_aliases # to make aliasses work in a bash script
source ~/.user_bashrc

 cat ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/h151/nct*
 grep -e broken -e overlap -e error ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/h151/nct* |sed -e 's/^.*log-nctcck.//' -e 's/.nct..k-.*log:/: /'
 ls -ld /scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-h151/h151/CMIP6//../