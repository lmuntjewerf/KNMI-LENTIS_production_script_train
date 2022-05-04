#!/bin/bash

set -ex

#-------------------
# untar only nemo files
#-------------------


# make it for the historical set
#declare -a scenarios
#scenarios=(h)

#for scenario in ${scenarios[@]}; do

#  for ic_member in {03..16}; do
#    member=$(printf "%02d" $ic_member)
#    scenario1=h
#    scenario_short=ha
#    scenario_full=historical
#    date=20000101
#    prevdate=199912
#    Thomas_folder=scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"

#    cd /"$Thomas_folder"/nemo/
#    tar -xvf ../../"$date".tar.gz "$Thomas_folder"/nemo/  --strip-components 19

#  done
#done

# make it for the scenario set
declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do

  for ic_member in {15..16}; do
    member=$(printf "%02d" $ic_member)
    scenario1=s
    scenario_short=s2
    scenario_full=ssp2-4.5
    date=20750101
    prevdate=207412
    Thomas_folder=scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"

    cd /"$Thomas_folder"/nemo/
    tar -xvf ../../"$date".tar.gz "$Thomas_folder"/nemo/  --strip-components 19

  done
done

