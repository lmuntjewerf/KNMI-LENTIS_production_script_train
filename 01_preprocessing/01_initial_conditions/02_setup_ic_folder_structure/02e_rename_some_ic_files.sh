#!/bin/bash

set -ex


################ TODO check dit loopje!
# er staat alleen ls in nu


declare -a scenarios
scenarios=(s)

for scenario in ${scenarios[@]}; do
  for ic_member in {01..16}; do
    member=$(printf "%02d" $ic_member)

    scenario_short=s2
    scenario_full=ssp2-4.5
    date=20750101

    folder=$SCRATCH/"$scenario_full"/"$scenario_full"-"$member"/"$date"/"$scenario_short""$member"/save_ic/"$date"
    ls "$folder"/ifs/ICMSH"$scenario_short""$member"INITr00
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

    folder=$SCRATCH/"$scenario_full"/"$scenario_full"-"$member"/"$date"/"$scenario_short""$member"/save_ic/"$date"
    ls "$folder"/ifs/ICMSH"$scenario_short""$member"INITr00
  done 
done





