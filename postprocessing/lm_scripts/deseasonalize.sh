#! /usr/bin/env bash

set -ex


#-------------------
# take out the seasonal cycle from daily (2D) timeseries 
# can be done AFTER _hc has been completed
#-------------------

declare -a casenames
casenames=(d116 d216 d316 Dd16 D016 D716 D816)

declare -a varlist
varlist=('tas')

startyear=2000
endyear=2000

# één tegelijk!
day=1
mon=0

#=========================================
# below this line no user edits necessary
#=========================================

for case in ${casenames[@]}; do
  for year in $(seq -f "%04g" $startyear $endyear); do
    for var in ${varlist[@]}; do
      if [[ $day -eq 1 ]]; then
        freq=day
        cdocommand=ydaymean
        infile=/scratch/ms/nl/"$USER"/ECEARTH-RUNS/"$case"/post/"$freq"/Post_"$year"/"$case"_"$year"_"$var"_"$freq".nc
        outfile=/scratch/ms/nl/"$USER"/ECEARTH-RUNS/"$case"/post/"$freq"/Post_"$year"/"$case"_"$year"_"$var"_"$freq"_deseasonalized.nc
      elif [[ $mon -eq 1 ]]; then
        freq=mon
        cdocommand=ymonmean
        infile=/scratch/ms/nl/"$USER"/ECEARTH-RUNS/"$case"/post/"$freq"/Post_"$year"/"$case"_"$year"_"$var".nc
        outfile=/scratch/ms/nl/"$USER"/ECEARTH-RUNS/"$case"/post/"$freq"/Post_"$year"/"$case"_"$year"_"$var"_deseasonalized.nc
      fi
  
      cdo sub $infile -$cdocommand $infile $outfile
    done
  done
done




