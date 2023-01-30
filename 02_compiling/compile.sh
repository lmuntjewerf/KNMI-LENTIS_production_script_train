#! /usr/bin/env bash

ACCOUNT= # name of your EC_billing_account
ECE3_dir= # path to the `../sources` directory of your ECE3 model code.

# ================================================
# Batch script for compiling the EC-Earth3 model 
# on the ECMWF-cca HPC. 
# 
# Written by Philippe le Sager
# Adapted by Laura Muntjewerf
#   laura.muntjewerf@gmail.com
# 
# ================================================


#PBS -N comp_ece
#PBS -q np
#PBS -l EC_billing_account=<ACCOUNT>
#PBS -j oe
#PBS -l walltime=01:30:00
#PBS -l EC_total_tasks=1
#PBS -l EC_threads_per_task=36

set -ex


# -------- SWITCHES
ecedir=${ECE3_dir}

confile='config-build.xml'

clean=1

with_oasis=1
with_nemo=1
with_ifs=1

# -------- CONFIG

    platform="ecmwf-cca-intel-mpi"
    njobs=8

#    module load PrgEnv-intel
    prgenvswitchto intel

    module load cray-hdf5-parallel/1.8.14
    module load cray-netcdf-hdf5parallel/4.3.3.1

# -- Comment if using eccodes
    module unload eccodes
    #module load grib_api/1.12.3 #-- working version -- will be removed in the foreseeable future 
    # default from nov18 on:
    module load grib_api/1.27.0

fi

echo "--------- final module list for compilation -----------" 
module list
echo "-------------------------------------------------------" 

# quirk due to "prgenvswitchto intel"
rm -f ${ecedir}/util/grib_table_126/define_table_126.sh


cd ${ecedir}
${ecedir}/util/ec-conf/ec-conf -p $platform ${confile}

# -------- OASIS
if (( $with_oasis ))
then
    echo; echo " *** COMPILING OASIS ***"; echo
    cd ${ecedir}/oasis3-mct/util/make_dir
    (( $clean )) && make BUILD_ARCH=ecconf -f TopMakefileOasis3 realclean
    make BUILD_ARCH=ecconf -f TopMakefileOasis3
fi

# -------- NEMO incl. xios, runoff-mapper
if (( $with_nemo ))
then
    # that one can fail when too many cores are involved
    echo; echo " *** COMPILING XIOS ***"; echo
    cd ${ecedir}/xios-2.5
    if (( $clean ))
    then
        ./make_xios --arch ecconf --use_oasis oasis3_mct --netcdf_lib netcdf4_par --full --job ${njobs}
    else
        ./make_xios --arch ecconf --use_oasis oasis3_mct --netcdf_lib netcdf4_par --job ${njobs}
    fi
    
    echo; echo " *** COMPILING RUNOFF ***"; echo
    cd ${ecedir}/runoff-mapper/src
    (( $clean )) && make clean
    make

    nemoconf='ORCA1L75_LIM3'                                # DEFAULT 

    echo; echo " *** COMPILING NEMO ${nemoconf} ***"; echo
    cd ${ecedir}/nemo-3.6/CONFIG
    echo "WD: $PWD"
    (( $clean )) && ./makenemo -n ${nemoconf} -m ecconf clean
    ./makenemo -n ${nemoconf} -m ecconf -j ${njobs}

    # Rebuild nemo
    cd ${ecedir}/nemo-3.6/TOOLS
    ./maketools -m ecconf -n REBUILD_NEMO

fi

# -------- IFS, incl. amip-reader
if (( $with_ifs ))
then
    echo; echo " *** COMPILING IFS ***"; echo
    cd ${ecedir}/ifs-36r4
    (( $clean )) && make BUILD_ARCH=ecconf realclean
    make BUILD_ARCH=ecconf -j ${njobs} lib
    make BUILD_ARCH=ecconf master
fi
  

