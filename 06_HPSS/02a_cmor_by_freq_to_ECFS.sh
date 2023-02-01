#!/bin/bash

set -ex

# ==================
# this script makes tar.gz files from all cmorized variable folders
# *tar.gz files are stored in the FREQUENCY folders (3hr, Amon etc)
# Arguments: 
#    $1 is FREQUENCY (3hr, Amon etc)
#    $2 is EXP (h011 etc)
#
# Laura Muntjewerf
# ==================


FREQUENCY=$1
EXP=$2



# ==================
# no need for user edits below
# info about where on ECFS it will go to
scenariofolder=${EXP:0:1}'xxx/'  # n.b. this can be hxxx or sxxx
ecfsdir='ec:/nklm/LENTIS/ec-earth/cmorised_by_var/'

tempfolder=$SCRATCH/cmor_temp/${EXP}/
mkdir -p ${tempfolder}

# get relevant info from path string cutting with delimiter '/'
cmordir=${SCRATCH}/cmorisation/cmorised-results
rdir0=${cmordir}/cmor-VAREX-cmip-${EXP}/${EXP}/CMIP6/*/KNMI/EC-Earth3/*/*/Amon/clt/gr/*
rdir=$(echo $rdir0)  # necessary to echo and parse into variable to get rid of the wildcards
rperiod=$(echo $rdir | cut -d "/" -f 11)
rscenario=$(echo $rdir | cut -d "/" -f 14)
rcode=$(echo $rdir | cut -d "/" -f 15)

#put the path back together for the namelist
cmorpath=${cmordir}/cmor-VAREX-cmip-${EXP}/${EXP}/CMIP6/${rperiod}/KNMI/EC-Earth3/${rscenario}/${rcode}/
cd ${cmorpath}

cd ${FREQUENCY}
for var in *; do
  echo ${var};
  tar -czvf ${tempfolder}${EXP}_${FREQUENCY}_${var}.tar.gz ${var}                   # tar the file
  ecfsdir_var=${ecfsdir}${scenariofolder}${FREQUENCY}/${var}                        # define the ECFS folder
  emv -o ${tempfolder}${EXP}_${FREQUENCY}_${var}.tar.gz ${ecfsdir_var}/             # -o: overwrite if already existing ;move (previous ecp/copy) tar file to ECFS -e if not already existing, otherwise keep old #rm -rf ${EXP}_${FREQUENCY}_${var}.tar.gz                             # remove the tar file
done  ;

#for var in *[!.]*; do
#  echo ${var};
#  rm -rf ${EXP}_${FREQUENCY}_${var}.tar.gz                             # remove the tar file
#done  ;

echo "Tar files are here:  ${ccadir}/${FREQUENCY}"
