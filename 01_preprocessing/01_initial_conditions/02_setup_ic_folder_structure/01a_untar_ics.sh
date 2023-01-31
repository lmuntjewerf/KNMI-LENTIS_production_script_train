#!/bin/bash

set -ex

#-------------------
# Untar all the ic folders from the Bull
#
# The script assumes the tar-files are in $SCRATCH
#
# x  instructs tar to extract the files from the zipped file
# v  means verbose, or to list out the files it's extracting
# z  instructs tar to decompress the files without this, you'd have a folder full of compressed files
# f  tells tar the filename you want it to work on
#
# Written by Laura Muntjewerf 
#   laura.muntjewerf@gmail.com
#-------------------



scenario=historical
for j in {01..16}; do
  tarfile=$SCRATCH/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20000101.tar.gz
  dest=$SCRATCH/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20000101
  mkdir -p $dest
  tar -xvzf $tarfile -C $dest/.
done

scenario=ssp2-4.5
for j in {1..16}; do
  tarfile=$SCRATCH/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20750101.tar.gz
  dest=$SCRATCH/"$scenario"/"$scenario"-"$(printf "%02d" $j)"/20750101
  mkdir -p $dest
  tar -xvzf $tarfile -C $dest/.
done




