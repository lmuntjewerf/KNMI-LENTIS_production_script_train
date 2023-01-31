#!/bin/bash

set -ex

#-------------------
# Untar only nemo files 
# User needs to specify the location of the GO TO folder. 
# Because the way it was saved, it is necessary do to some stripping of the folder structure
#
# # Written by Laura Muntjewerf 
#   laura.muntjewerf@gmail.com
#-------------------


# make it for the historical set
declare -a scenarios
scenarios=(h)

for scenario in ${scenarios[@]}; do

  for ic_member in {03..16}; do
    member=$(printf "%02d" $ic_member)
    scenario1=h
    scenario_short=ha
    scenario_full=historical
    date=20000101
    prevdate=199912
    folder=

    cd /"$folder"/nemo/
    tar -xvf ../../"$date".tar.gz "$folder"/nemo/  --strip-components 19

  done
done

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
    folder=

    cd /"$folder"/nemo/
    tar -xvf ../../"$date".tar.gz "$folder"/nemo/  --strip-components 19

  done
done

