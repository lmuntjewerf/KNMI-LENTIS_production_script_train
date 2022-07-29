#!/bin/bash

#-------------------
# ECtrans unattended file transfer to a member state server
#  https://confluence.ecmwf.int/display/ECAC/Unattended+file+transfer+-+ectrans 
#-------------------

file=ec:/nklm/LENTIS/ec-earth/validation/h011/file-overview--h011.txt

ectrans -gateway muntjewe@pc200021:/usr/people/muntjewe/ \
          -remote muntjewe@pc200021 \
          -source ${file} \
          -verbose
#verbose: gateway=ecaccess.knmi.nl
#verbose: echost=cca.ecmwf.int
#verbose: action=spool
#verbose: ecuser=uid
#verbose: source=fff
#verbose: target=fff
#verbose: keep=false
#verbose: remove=false
#verbose: option=reject
#verbose: lifetime=1w
#verbose: delay=(none)
#verbose: at=(now)
#verbose: format=yyyyMMddHHmmss
#verbose: retryCnt=144
#verbose: retryFrq=10m
