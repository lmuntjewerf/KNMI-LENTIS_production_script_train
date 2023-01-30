#!/bin/bash


#-------------------
# check all the nemo and ifs input files are there for the 16 historical and the 16 ssp2-4.5 members
#-------------------

# make it for the historical set
declare -a scenarios
scenarios=(h)

for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)
    scenario_short=ha
    scenario_full=historical
    date=20000101
    Thomas_folder=scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"

    cd /"$Thomas_folder"/nemo/
    echo 'nemo '"$scenario_short""$member"
    ls -l  | wc -l 

    cd /"$Thomas_folder"/ifs/
    echo 'ifs '"$scenario_short""$member"
    ls -l  | wc -l 

  done
done

# make it for the scenario set
declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)
    scenario_short=s2
    scenario_full=ssp2-4.5
    date=20750101
    Thomas_folder=scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"

    cd /"$Thomas_folder"/nemo/
    echo "$scenario_short""$member"
    ls -l | wc -l 

    cd /"$Thomas_folder"/ifs/
    echo 'ifs '"$scenario_short""$member"
    ls -l  | wc -l

  done
done



