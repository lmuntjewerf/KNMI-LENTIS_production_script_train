#!/bin/bash

set -ex

user=nklm



declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do
  for ic_member in {01..14}; do
    member=$(printf "%02d" $ic_member)

    scenario_short=s2
    scenario_full=ssp2-4.5
    date=20750101

    Thomas_folder=/scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"

    ls "$Thomas_folder"/ifs/ICMSH"$scenario_short""$member"INITr00
    #mv "$Thomas_folder"/ifs/ICMSH"$scenario_short""$member"INITr00 "$Thomas_folder"/ifs/ICMSH"$scenario_short""$member"INITr0
  done
done

declare -a scenarios
scenarios=(h)

for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)

    scenario_short=ha
    scenario_full=historical
    date=20000101

      
    Thomas_folder=/scratch/ms/nl/nklm/from_Thomas/dutch-scenarios/"$scenario_full"/"$scenario_full"-"$member"/"$date"/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/"$scenario_short""$member"/save_ic/"$date"
    ls "$Thomas_folder"/ifs/ICMSH"$scenario_short""$member"INITr00
    #mv "$Thomas_folder"/ifs/ICMSH"$scenario_short""$member"INITr00 "$Thomas_folder"/ifs/ICMSH"$scenario_short""$member"INITr0
  done 
done





