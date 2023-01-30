#!/bin/bash

scenariofolder='hxxx/'
ecfsdir='ec:/nklm/LENTIS/ec-earth/cmorised_by_var/'

dir=/scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-s016/s016/CMIP6/ScenarioMIP/KNMI/EC-Earth3/ssp245/r5016i6p5f1/
#dir=/scratch/ms/nl/nklm/cmorisation/cmorised-results/cmor-VAREX-cmip-h011/h011/CMIP6/CMIP/KNMI/EC-Earth3/historical/r1011i1p5f1/
cd ${dir}


#  make the ECFS dirs
for frequency in *[!.]; do
  echo ${frequency} 
  cd ${frequency}
  for var in *[!.]; do
    echo ${var}; 
    emkdir -p ${ecfsdir}${scenariofolder}${frequency}/${var}
  done  ; 
  cd ..; 
done


