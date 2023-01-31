#!/bin/bash

#set -ex

#-------------------
# rename and symlink the nemo restart files
#
# # Written by Laura Muntjewerf 
#   laura.muntjewerf@gmail.com
#-------------------

# make it for the historical set
declare -a scenarios
scenarios=(h)

for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
   member=$(printf "%02d" $ic_member)
   for ic_seed in {0..9}; do
     seed=$(printf "%01d" $ic_seed)
     scenario1=h
     scenario_short=ha
     scenario_full=historical
     date=20000101
     prevdate=199912

     ic_name=${scenario_short}${member}
     exp_name=${scenario}${member}${seed}

     folder=$SCRATCH/"$scenario_full"/"$scenario_full"-"$member"/"$date"/${ic_name}/save_ic/"$date"
     dest_folder=$SCRATCH/sets_ic_files/${scenario}${member}${seed}/nemo/

     cd ${folder}/nemo/.
      
     for i in `find . -name "*${ic_name}*"`; do
        mkdir -p "$dest_folder"
        ln -s ${folder}/nemo/${i} $dest_folder/${i/"${ic_name}"/"${exp_name}"} ;
     done
   done
 done
done



# make it for the scenario set
declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do
  for ic_member in {1..16};do
    member=$(printf "%02d" $ic_member)
    for ic_seed in {0..9}; do
      seed=$(printf "%01d" $ic_seed)
      scenario1=s
      scenario_short=s2
      scenario_full=ssp2-4.5
      date=20750101
      prevdate=207412

      ic_name=${scenario_short}${member}
      exp_name=${scenario}${member}${seed}

      folder=$SCRATCH/"$scenario_full"/"$scenario_full"-"$member"/"$date"/${ic_name}/save_ic/"$date"
      dest_folder=$SCRATCH/sets_ic_files/${scenario}${member}${seed}/nemo/

      cd ${folder}/nemo/.
      echo ${folder}
      for i in `find . -name "*${ic_name}*"`; do

         mkdir -p "$dest_folder"
         ln -s ${folder}/nemo/${i} $dest_folder/${i/"${ic_name}"/"${exp_name}"} ;
      done
    done
  done
done





