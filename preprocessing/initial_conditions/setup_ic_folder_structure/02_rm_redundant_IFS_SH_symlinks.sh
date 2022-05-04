#!/bin/bash

set -ex

#-------------------
# correct the ICMSHh011INIT symlink to the right perturbed initial condition seed
# remove all other redundant ICMSHh011INITr* symlinks of the other perturbed initial conditions
# run this script after 01_symlink_all_IFS_icfiles.sh 
#-------------------

# choose ifs or nemo 
model=ifs





#---- no user edits below ----
scenarios=(s)
ic_folder=/scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/
for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)
    for ic_seed in {0..9}; do
      seed=$(printf "%01d" $ic_seed)
      icneeded=${ic_folder}${scenario}${member}${seed}/${model}/ICMSH${scenario}${member}${seed}INIT
      icseed=${ic_folder}${scenario}${member}${seed}/${model}/ICMSH${scenario}${member}${seed}INITr${seed}
      mv ${icseed} ${icneeded}
      #echo ${icseed}
      rm -rf ${icneeded}r*
    done
  done
done



