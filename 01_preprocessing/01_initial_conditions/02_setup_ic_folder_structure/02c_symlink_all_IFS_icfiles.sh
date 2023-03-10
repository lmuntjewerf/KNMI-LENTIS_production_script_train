#!/bin/bash

set -ex

#-------------------
# rename and symlink the ifs restart files
# run this script first, then run 02_rm_redundant_IFS_SH_symlinks.sh to correct the ICMSHh011INIT symlink  to the right perturbed initial condition seed
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

      ic_name=${scenario_short}${member}
      exp_name=${scenario}${member}${seed}

      folder=$SCRATCH/"$scenario_full"/"$scenario_full"-"$member"/"$date"/${ic_name}/save_ic/"$date"
      dest_folder=$SCRATCH/sets_ic_files/${scenario}${member}${seed}/ifs/

      cd ${folder}/ifs/.
      
      for i in `find . -name "*${ic_name}*"`; do

         #echo ${i} ;  # dit is de bestaande orig file
         #echo $dest_folder${i/"${ic_name}"/"${exp_name}"} ;  # dit is de naam van de symlink
         mkdir -p "$dest_folder"
         ln -s ${folder}/ifs/${i} $dest_folder/${i/"${ic_name}"/"${exp_name}"} ;
      done
    done
  done
done



# make it for the scenario set
declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do

  for ic_member in {01..16};do
    member=$(printf "%02d" $ic_member)
    for ic_seed in {0..9}; do
      seed=$(printf "%01d" $ic_seed)
      scenario1=s
      scenario_short=s2
      scenario_full=ssp2-4.5
      date=20750101

      ic_name=${scenario_short}${member}
      exp_name=${scenario}${member}${seed}

      folder=$SCRATCH/"$scenario_full"/"$scenario_full"-"$member"/"$date"/${ic_name}/save_ic/"$date"
      dest_folder=$SCRATCH/sets_ic_files/${scenario}${member}${seed}/ifs/

      cd ${folder}/ifs/.

      for i in `find . -name "*${ic_name}*"`; do

         #echo ${i} ;  # dit is de bestaande orig file
         #echo $dest_folder${i/"${ic_name}"/"${exp_name}"} ;  # dit is de naam van de symlink
         mkdir -p "$dest_folder"
         ln -s ${folder}/ifs/${i} $dest_folder/${i/"${ic_name}"/"${exp_name}"} ;
      done
    done
  done
done


