#! /usr/bin/env bash

set -ex

# can be done AFTER _ts has been completed

declare -a casenames
casenames=(d116 d216 d316)

startyear=2000
endyear=2001

for case in ${casenames[@]}; do
   cdo yearmean /home/ms/nl/nklm/ecearth3/diag//timeseries/"$case"/atmosphere/"$case"_"$startyear"_"$endyear"_time-series_atmo.nc  /home/ms/nl/nklm/ecearth3/diag//timeseries/"$case"/atmosphere/"$case"_"$startyear"_"$endyear"_ANNtime-series_atmo.nc
done

