#!/bin/bash

set -ex


# Setup the h010-t169 experiments (control historical starting at year 2000 upto perturbed convection ssp245 at year 2075 for their 9 perturbed intial states):
# from: ${PERM}/ec-earth-3/branch-varex-control/runtime/classic/set-ensemble-member-changes.sh

# Set some aliases/functions:
function svns()  { svn stat | grep -v "^?" ; }
function svncleannonversioned() { svn stat --no-ignore | grep -v -e svn-clean-non-versioned.sh | sed -e "s/?      /rm -rf /" -e "s/I      /rm -rf /"  | grep "rm -rf" > svn-clean-non-versioned.sh ; chmod uog+x svn-clean-non-versioned.sh ; ./svn-clean-non-versioned.sh ; rm -f svn-clean-non-versioned.sh ; }

# Check first that the directory which will be copied is update and without changes:
submit_dir_ece=${SCRATCH}/submit-ec-earth-3
svn checkout https://svn.ec-earth.org/ecearth3/branches/projects/varex/runtime/classic ${submit_dir_ece}/branch-varex-h010
cd ${submit_dir_ece}/branch-varex-h010

svn stat | grep -v "^?" ; svn info; svn update


for k in {h,s}; do
 for j in $(seq -f "%02g" 1 16) ; do  # zero padding
  for i in {0..9}; do
   rsync -a branch-varex-h010/ branch-varex-${k}${j}${i}
   cd ${submit_dir_ece}/branch-varex-${k}${j}${i}
   svncleannonversioned
   ./set-ensemble-member-changes.sh ${k}${j}${i}
   cd ../
  done
 done
done


