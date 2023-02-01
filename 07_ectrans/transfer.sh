#!/bin/bash

#-------------------
# ECtrans unattended file transfer to a member state server
#  https://confluence.ecmwf.int/display/ECAC/Unattended+file+transfer+-+ectrans 
#
# download all 160 members in this case of: PD (h) tas daily
#
# user needs to provide the member gateway and remote_name
#
# # Laura Muntjewerf
#-------------------

scenario=h
freq=day
var=tas

member_gateway=
remote_name=

for i in {1..16}; do 
  for j in {0..9}; do 
    ectrans -gateway ${member_gateway} -remote ${remote_name}@genericSftp -source $SCRATCH/${scenario}"$(printf "%02d" $i)"${j}_${freq}_${var}.tar.gz ; 
  done; 
done





