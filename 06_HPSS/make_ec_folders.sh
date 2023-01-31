#!/bin/bash

scenariofolder='hxxx/'
ecfsdir='ec:/nklm/LENTIS/ec-earth/cmorised_by_var/'

dir=$SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-s016/s016/CMIP6/ScenarioMIP/KNMI/EC-Earth3/ssp245/r5016i6p5f1/
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


