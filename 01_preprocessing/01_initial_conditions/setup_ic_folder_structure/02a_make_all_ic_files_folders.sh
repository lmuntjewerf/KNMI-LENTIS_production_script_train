#!/bin/bash

set -ex


# ==================================================
# Script to set up initial conditions for the VAREX-LE experiments
#
# Steps: 
#  0) if necessary: remove previous folder (uncomment if yes)
#  1) create folder with correct name
#  2) symlink OASIS folder in full entirely
#  3) use other scripts to symlink IFS and NEMO files (i.e., symlink_all_nemo_restarts.sh and symlink_all_ifs_restarts.sh)
#
# ==================================================


user=nklm


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

      Thomas_folder=/scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"


      # 0) if necessary: remove previous folder
      #rm -rf /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"/*

      # 1) create folder with correct name
      mkdir -p /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"
      
      # 2) symlink OASIS folder in full entirely
      ln -s "$Thomas_folder"/oasis /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"/.

      # 3) use other scripts to symlink IFS and NEMO files
 
    done
  done
done

# make it for the scenario set
declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do

  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)
    for ic_seed in {0..9}; do
      seed=$(printf "%01d" $ic_seed)
      scenario1=s
      scenario_short=s2
      scenario_full=ssp2-4.5
      date=20750101
      prevdate=207412

      Thomas_folder=/scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"

      # 0) if necessary: remove previous folder
      #rm -rf /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"/*

      # 1) create folder with correct name
      mkdir -p /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"

      # 2) symlink OASIS folder in full entirely
      ln -s "$Thomas_folder"/oasis /scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/"$scenario""$member""$seed"/.

      # 3) use other scripts to symlink IFS and NEMO files
      
    done
  done
done

