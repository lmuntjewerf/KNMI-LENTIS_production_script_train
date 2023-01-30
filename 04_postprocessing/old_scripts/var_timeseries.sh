#!/usr/bin/env bash

set -ex

user=nklm
scratchdir=/scratch/ms/nl/$user
tempdir=/scratch/ms/nl/$user/temp/
mkdir -p $tempdir
#opruimdir=
#mkdir -p $opruimdir

#------------------------------------------
# case details
#------------------------------------------
startyear=2000
endyear=2005

declare -a casenames
casenames=(D016 D116 D216 D316 D416 Dd16)

declare -a varlistGG
varlistGG=(TSR TTR)

#------------------------------------------
# script does stuff, no user edits below here
#------------------------------------------
#years=($(seq $startyear 1 $endyear))
#idirs=($(seq -f "%03g" 1 ${#years[@]}))


#for casename in ${casenames[@]}; do
#  for ((i=0; i<${#years[@]}; ++i)); do
#    year=${years[i]}
#    idir=${idirs[i]}
#    # define where the data is now
#    indir=$scratchdir"/ECEARTH-RUNS/"$casename"/output/ifs/"$idir
#    for month in $(seq -f "%02g" 1 12); do
#      # make netCDF files from the GRIB files
#      cdo -t ecmwf -f nc setgridtype,regular $indir"/ICMGG"$casename"+"$year$month $tempdir"/ICMGG"$casename"+"$year$month".nc"
      #cdo -t ecmwf -f nc setgridtype,regular $indir"/ICMSH"$casename"+"$year$month $tempdir"/ICMSH"$casename"+"$year$month".nc"
#    done
#  done
#done
#echo "FINISHED PRODUCTS are here: " $tempdir

for casename in ${casenames[@]}; do
  for var in ${varlistGG[@]}; do
    echo $var
    for year in $(seq -f "%04g" $startyear $endyear); do
      for month in $(seq -f "%02g" 1 12); do
        cdo selvar,"$var" $tempdir"/ICMGG"$casename"+"$year$month".nc" $tempdir"/"$var"_ICMGG_"$casename"_"$year"_"$month".nc"
      done
    done
    opruimdir=$tempdir
    cdo cat $tempdir"/"$var"_ICMGG_"$casename"_????_??.nc" $opruimdir"/"$var"_ICMGG_"$casename"_"$startyear"-"$endyear".nc"
  done
  #rm $tempdir"/"$var"*"$casename"*.nc"
done

echo "FINISHED PRODUCTS are here: " $tempdir


#scratchdir=/scratch/ms/nl/nklm/ECEARTH-RUNS/

#for test in KN15 KN17; do
#  for month in $(seq -f "%02g" 1 12); do
#    cdo -t ecmwf -f nc setgridtype,regular $scratchdir/$test/output/ifs/001/ICMGG"$test"+2000"$month" $scratchdir/$test/output/ifs/001/ICMGG"$test"+2000"$month".nc
#    cdo -t ecmwf -f nc setgridtype,regular $scratchdir/$test/output/ifs/001/ICMSH"$test"+2000"$month" $scratchdir/$test/output/ifs/001/ICMSH"$test"+2000"$month".nc
#  done
#done

#for test in KN15 KN17; do
#   cdo mergetime $scratchdir/$test/output/ifs/001/ICMGG"$test"+2000*.nc $scratchdir/$test/output/ifs/001/ICMGG"$test"+2000.nc
#   cdo mergetime $scratchdir/$test/output/ifs/001/ICMSH"$test"+2000*.nc $scratchdir/$test/output/ifs/001/ICMSH"$test"+2000.nc
#done


