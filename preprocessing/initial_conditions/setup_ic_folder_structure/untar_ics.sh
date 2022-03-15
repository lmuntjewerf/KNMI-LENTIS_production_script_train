#!/bin/bash

set -ex

#-------------------
# Untar all the ic folders from Thomas, from the Bull
#
# x  instructs tar to extract the files from the zipped file
# v  means verbose, or to list out the files it's extracting
# z  instructs tar to decompress the files without this, you'd have a folder full of compressed files
# f  tells tar the filename you want it to work on
#-------------------



scenario=historical
for j in {01..16}; do
  #ls $SCRATCH/from_Thomas/dutch-scenarios/"$scenario"/"$scenario"-$(printf "%02d" $j)
  tarfile=$SCRATCH/from_Thomas/dutch-scenarios/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20000101.tar.gz
  dest=$SCRATCH/from_Thomas/dutch-scenarios/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20000101
  mkdir -p $dest
  tar -xvzf $tarfile -C $dest/.
done

scenario=ssp2-4.5
for j in {01..14}; do
  #ls $SCRATCH/from_Thomas/dutch-scenarios/"$scenario"/"$scenario"-$(printf "%02d" $j)
  tarfile=$SCRATCH/from_Thomas/dutch-scenarios/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20750101.tar.gz
  dest=$SCRATCH/from_Thomas/dutch-scenarios/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20750101
  mkdir -p $dest
  tar -xvzf $tarfile -C $dest/.
done




