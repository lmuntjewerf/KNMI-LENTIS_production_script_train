#!/bin/bash

set -ex


icdir=/scratch/ms/nl/nklm/from_Thomas/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/ha16/save_ic/20000101/ifs/

for seed in {1..9}; do
   #echo $(printf "%01d" $seed)
   perturb_var_eccodes.py -s 't' -d $(printf "%01d" $seed) $icdir"/ICMSHha16INIT" $icdir"/ICMSHha16INITr"$(printf "%01d" $seed) ; 
done

#./perturb_var.py -s 't' -d 1 /scratch/ms/nl/nklm/from_Thomas/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/ha16/save_ic/20000101/ifs/ICMSHha16INIT /scratch/ms/nl/nklm/from_Thomas/lustre2/projects/dutch_scen/reerink/ec-earth-3/branch-knmi23-dutch-climate-scenarios/ha16/save_ic/20000101/ifs/ICMSHha16INITr1


