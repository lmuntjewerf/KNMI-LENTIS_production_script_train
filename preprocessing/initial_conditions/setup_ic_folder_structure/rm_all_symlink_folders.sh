#!/bin/bash

set -ex

#-------------------
# remove all symlink folders for model ifs or nemo
#-------------------

# choose ifs or nemo 
model=ifs





#---- no user edits below ----

scenarios=(h s)
ic_folder=/scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/
for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)
    for ic_seed in {0..9}; do
      seed=$(printf "%01d" $ic_seed)
      for i in ${ic_folder}${scenario}${member}${seed}/${model}; do 
        #echo $i
        rm -rf $i 
      done
    done
  done
done

