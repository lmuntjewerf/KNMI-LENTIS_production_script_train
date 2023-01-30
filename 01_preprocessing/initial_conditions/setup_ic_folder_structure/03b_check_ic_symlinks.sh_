#!/bin/bash



sets_ic_files=/scratch/ms/nl/nklm/MSO_VAREX/sets_ic_files/

cd $sets_ic_files


echo 'Counting NEMO symlinks --> should be 561 (560+1'
for f in *; do echo $f ; ls -l $f/nemo/ | wc -l  ; done

echo 'Counting IFS symlinks --> should be 11 (10+1)'
for f in *; do echo $f ;  ls -l $f/ifs/ | wc -l ; done
