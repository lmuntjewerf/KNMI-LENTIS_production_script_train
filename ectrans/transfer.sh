#!/bin/bash

#-------------------
# ECtrans unattended file transfer to a member state server
#  https://confluence.ecmwf.int/display/ECAC/Unattended+file+transfer+-+ectrans 
#
# download all 160 members 
#-------------------

scenario=h
freq=day
var=tasmax

for i in {1..16}; do 
  for j in {0..9}; do 
    ectrans -gateway ecaccess.knmi.nl -remote LENTIS@genericSftp -source /scratch/ms/nl/nklm/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz ; 
  done; 
done





