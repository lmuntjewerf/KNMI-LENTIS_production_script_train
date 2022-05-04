#! /usr/bin/env bash

#PBS -N comp_ece
#PBS -q np
#PBS -l EC_billing_account=nlmonkli
#PBS -j oe
#PBS -l walltime=01:30:00
#PBS -l EC_total_tasks=1
#PBS -l EC_threads_per_task=36

# with CRAY compiler, nemo and xios must be compiled with one 1 thread. Xios is very slow. Must use:

# PLS #PBS -N comp32_serial.jb
# PLS #PBS -q ns
# PLS #PBS -j oe
# PLS #PBS -o comp_321_serial_2.log

set -ex

# written by Philippe (/home/ms/nl/nm6/ECEARTH/utils/compile.sh)


# -------- SWITCHES
#ecedir='/perm/ms/nl/nm6/primavera/sources' 
#ecedir='/perm/ms/nl/nm6/trunk/sources' 
#ecedir='/scratch/ms/nl/nm6/3.3-AerChem/sources' 
#ecedir='/perm/ms/nl/nklm/ECEarth_bis/sources'
#ecedir='/perm/ms/nl/nklm/ecearth3.3.2/sources'
#ecedir='/perm/ms/nl/nklm/trunk/sources'
#ecedir='/perm/ms/nl/nklm/knmi23-dutch-climate-scenarios/sources'
#ecedir='/perm/ms/nl/nklm/ec-earth-3/branch-varex-control/sources'
ecedir='/perm/ms/nl/nklm/ec-earth-3/varex/sources'

confile='config-build.xml'

do_primavera=0
xios2=${do_primavera}        # use the xios 2.0 originally in Primavera branch

use_cray=0

clean=1

with_oasis=1
with_nemo=1
with_ifs=1
with_amip=0
with_tm5=0
with_lpj=0
with_offline_lpj=0
with_osm=0

# xtra for NEMO
with_elpin=0

# alternate configs for NEMO. Pick ONE (not all available in all branches).
do_hires=0
do_shires=0
do_pisces=0
do_ccycle=0

#.. with (0) or w/o (1) IFS:
nemo_alone=0

# tool
with_lucia=0

# -------- CONFIG

#module unload PrgEnv-cray
#module unload PrgEnv-intel
#module unload PrgEnv-gnu

if (( $use_cray ))
then 
    platform="cca-cray-craympi"
    njobs=1
    #module unload PrgEnv-intel
    #module load PrgEnv-cray
else
    platform="ecmwf-cca-intel-mpi"
    (( $do_primavera )) && platform="cca-intel-mpi"
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

    # for TM5
    module load udunits
    module load hdf
    # for lpjg
    module load cmake
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
    (( $xios2 )) && cd ${ecedir}/xios-2 || cd ${ecedir}/xios-2.5
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
    (( $do_pisces)) && nemoconf='ORCA1L75_LIM3_PISCES'      # 
    (( $do_ccycle)) && nemoconf='ORCA1L75_LIM3_CarbonCycle' # 
    (( $do_hires )) && nemoconf='ORCA025L75_LIM3'           # 
    (( $do_shires)) && nemoconf='ORCA12L75_LIM3'            # 

    (( nemo_alone )) && nemoconf=${nemoconf}_standalone

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
  
if (( $with_amip ))
then  
    echo; echo " *** COMPILING AMIP-READER ***"; echo
    cd ${ecedir}/amip-forcing/src
    (( $clean )) && make clean
    make

fi

# always install grib_table since we have to remove it to be able to run ec-conf
if ! (( $do_primavera )) ; then
    echo; echo " *** INSTALLING GRI BTABLE 126 ***"; echo
    cd ${ecedir}/util/grib_table_126
    ./define_table_126.sh
fi

# -------- TM5
if (( $with_tm5 ))
then
    echo; echo " *** COMPILING TM5 ***"; echo
    cd ${ecedir}/tm5mp
    (( $clean )) && setup_tm5 -n ecconfig-ecearth3.rc || setup_tm5 ecconfig-ecearth3.rc
fi

# -------- LPJG
if (( $with_lpj ))
then
    echo; echo " *** COMPILING LPJG ***"; echo
    cd ${ecedir}/lpjg/build
    #(( $clean )) && \rm -rf CMakeCache.txt CMakeFiles cmake_install.cmake cru framework guess libraries Makefile modules
    cmake ..
    make
fi

# --------- LPJG offline
if (( $with_offline_lpj ))
then
    echo; echo " *** COMPILING OFFLINE LPJG ***"; echo
    cd ${ecedir}/lpjg/offline
    make 
fi

# -------- OSM
if (( $with_osm ))
then
    module load fcm
    cd ${ecedir}/ifs-36r4/src/surf/offline/
    fcm make -v -j 2
fi

# -------- ELPin
if (( $with_elpin ))
then
    echo; echo " *** COMPILING ELPiN ***"; echo
    cd ${ecedir}/util/ELPiN/
    (( $clean )) && make clean
    make    
    
    # howto
    # - add nemo:elpin to config var
    # - be sure that ncdump is avail when the script is executed

fi

# -------- LUCIA
if (( $with_lucia ))
then
    echo; echo " *** COMPILING LUCIA ***"; echo
    cd ${ecedir}/oasis3-mct/util/lucia
    F90=ftn ./lucia -c
fi
