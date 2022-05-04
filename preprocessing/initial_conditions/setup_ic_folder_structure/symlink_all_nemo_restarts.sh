#!/bin/bash

#set -ex

#-------------------
# rename and symlink the nemo restart files
#-------------------

# make it for the historical set
#declare -a scenarios
#scenarios=(h)

#for scenario in ${scenarios[@]}; do

  #for ic_member in {01..16}; do
#  for ic_member in {03..16}; do
#    member=$(printf "%02d" $ic_member)
#    #for ic_seed in {0..9}; do
#    for ic_seed in {0..9}; do
#      seed=$(printf "%01d" $ic_seed)
#      scenario1=h
#      scenario_short=ha
#      scenario_full=historical
#      date=20000101
#      prevdate=199912

#      ic_name=${scenario_short}${member}
#      exp_name=${scenario}${member}${seed}

#      Thomas_folder=/scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/${ic_name}/save_ic/"$date"

#      dest_folder=/scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/${scenario}${member}${seed}/nemo/

#      cd ${Thomas_folder}/nemo/.
      
#      for i in `find . -name "*${ic_name}*"`; do

        # echo ${i} ;  # dit is de bestaande orig file
         #echo $dest_folder${i/"${ic_name}"/"${exp_name}"} ;  # dit is de naam van de symlink
         #mkdir -p "$dest_folder"
         #ln -s ${Thomas_folder}/nemo/${i} $dest_folder/${i/"${ic_name}"/"${exp_name}"} ;
         #ln -s ${i} "$dest_folder"/"${i/"${ic_name}"/"${exp_name}"}" ;
        # ln -s ${i} /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"/nemo/${i/ha01/h010};
        # mv ${i} ${i/ha01/h010}; 
#      done
#    done
#  done
#done



# make it for the scenario set
declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do

  #for ic_member in {01..14}; do
  for ic_member in {15..16};do
    member=$(printf "%02d" $ic_member)
    #for ic_seed in {0..9}; do
    for ic_seed in {0..9}; do
      seed=$(printf "%01d" $ic_seed)
      scenario1=s
      scenario_short=s2
      scenario_full=ssp2-4.5
      date=20750101
      prevdate=207412

      ic_name=${scenario_short}${member}
      exp_name=${scenario}${member}${seed}

      Thomas_folder=/scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/${ic_name}/save_ic/"$date"

      dest_folder=/scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/${scenario}${member}${seed}/nemo/

      cd ${Thomas_folder}/nemo/.
      echo ${Thomas_folder}
      for i in `find . -name "*${ic_name}*"`; do

         #echo ${i} ;  # dit is de bestaande orig file
         #echo $dest_folder${i/"${ic_name}"/"${exp_name}"} ;  # dit is de naam van de symlink
         mkdir -p "$dest_folder"
         ln -s ${Thomas_folder}/nemo/${i} $dest_folder/${i/"${ic_name}"/"${exp_name}"} ;
         #ln -s ${i} /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"/nemo/${i/ha01/h010};
         #mv ${i} ${i/ha01/h010}; 
      done
    done
  done
done





