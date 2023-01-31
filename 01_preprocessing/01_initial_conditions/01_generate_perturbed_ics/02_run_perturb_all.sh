#!/bin/bash

set -ex

#-------------------
# perturb the initial condition files of hist and ssp2-4.5
# the perturbed ic files are called r01-r09 for the seed used
# the orig is renamed r00
#
# Written by Laura Muntjewerf 
#   laura.muntjewerf@gmail.com
#-------------------


scenario=historical

for j in {01..16}; do
  for seed in {1..9}; do
    icdir="$SCRATCH"/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20000101/ha"$(printf "%02d" $j)"/save_ic/20000101/ifs/
    in_icfile="$icdir"/ICMSHha"$(printf "%02d" $j)"INIT
    out_icfile="$icdir"/ICMSHha"$(printf "%02d" $j)"INITr"$(printf "%01d" $seed)"

    perturb_var_eccodes.py -s 't' -d "$(printf "%01d" $seed)" "$in_icfile" "$out_icfile"
  done
  cp "$icdir"/ICMSHha"$(printf "%02d" $j)"INIT "$icdir"/ICMSHha"$(printf "%02d" $j)"INITr0

done


scenario=ssp2-4.5

for j in {1..16}; do
  for seed in {1..9}; do
    icdir="$SCRATCH"/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20750101/s2"$(printf "%02d" $j)"/save_ic/20750101/ifs/
    in_icfile="$icdir"/ICMSHs2"$(printf "%02d" $j)"INIT
    out_icfile="$icdir"/ICMSHs2"$(printf "%02d" $j)"INITr"$(printf "%01d" $seed)"
    #echo "$out_icfile"
    perturb_var_eccodes.py -s 't' -d "$(printf "%01d" $seed)" "$in_icfile" "$out_icfile"
  done
  cp "$icdir"/ICMSHs2"$(printf "%02d" $j)"INIT "$icdir"/ICMSHs2"$(printf "%02d" $j)"INITr0

done




