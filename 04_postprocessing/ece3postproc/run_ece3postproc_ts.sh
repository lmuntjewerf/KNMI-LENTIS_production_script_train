#! /usr/bin/env bash

set -ex

# can be done AFTER _hc has been completed

declare -a casenames
casenames=(d116 d216 d316)


ece3postprocdir=/home/ms/nl/nklm/from/Philippe/ece3-postproc/

cd $ece3postprocdir"/script"

for case in ${casenames[@]}; do
  ./ts.sh $case 
done

