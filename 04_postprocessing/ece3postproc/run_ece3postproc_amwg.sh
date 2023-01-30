#! /usr/bin/env bash

set -ex

#startyear=2000
#endyear=2009

startyear=2075
endyear=2084

declare -a casenames
#casenames=(h010  h011  h020)
casenames=(s010)

ece3postprocdir=/home/ms/nl/nklm/from/Philippe/ece3-postproc/

cd $ece3postprocdir"/script"

for case in ${casenames[@]}; do
  ./amwg.sh $case $startyear $endyear 
done

