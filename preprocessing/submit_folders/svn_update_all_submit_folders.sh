#!/bin/bash

#set -ex

svn_username=$1
svn_password=$2

#-------------------
# Run this script without arguments for examples how to call this script.
# svn revert and update all submit folders
# give svn_username and svn_password as arguments to the bash script
#-------------------

if [ "$#" -lt 2 ]; then
  echo
  echo ' Illegal number of arguments: the script requires two arguments: the svn username and the svn password. Run e.g. like:'
  echo ' ' $0 'svnusername xxpasswordxx'
  echo

elif [ "$#" -eq 2 ]; then
  submit_dir_ece=${SCRATCH}/submit-ec-earth-3/
  #for k in {h,i,j,s,u,t}; do
  for k in {h,s}; do
   for j in $(seq -f "%02g" 1 16); do # zero padding
    for i in {0..9}; do
     cd ${submit_dir_ece}/branch-varex-${k}${j}${i}
     echo --username $svn_username --password $svn_password
     #svn revert .
     #svn update --username $svn_username --password $svn_password
     cd ../
    done
   done
  done
fi


