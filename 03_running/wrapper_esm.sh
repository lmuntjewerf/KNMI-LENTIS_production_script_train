#!/usr/bin/env bash

set -e
#            ORDER = {XIO}:{NEM}:{IFS}:{LPJG}:{TM5}:{AMIP}:{RON}
#################################################################################
# This wrapper simplifies run submission on cca at ECMWF. It:                   #
#    - reads the config-run.xml                                                 #
#    - create a submit script with the correct directives                       #
#    - submit it                                                                #
#                                                                               #
# HOW-TO :                                                                      #
#    0) copy this file in your rundir/classic                                   #
#    1) set here your cca account (if empty your default ECMWF account is used) #
#    2) set here the models configuration with the MYCONFIG variable,           #
#    3) configure your run with the config-run.xml,                             #
#    4) run this script                                                         #
#                                                                               #
# Log of submit script is in "./out" dir (created if needed)                    #
#                                                                               #
# REQUIREMENTS: ec-conf and get_ece_config_param.py are in your $PATH. They are #
#                available in the ec-earth distribution, under the sources/util #
#                dir.                                                           #
#             OR use:                                                           #
PATH=$PATH:../../sources/util/ec-conf:../../sources/util/misc
#################################################################################

#ACCOUNT=spnltune
MYCONFIG="ifs nemo lim3 rnfmapper xios:detached oasis"

mailadress='laura.muntjewerf@gmail.com' # PBS sends email for job abe (abort/begin/end)

# -- Possible configurations -- (everything possible except nemo standalone)
# 
#  MYCONFIG="ifs amip "                                                        
#  MYCONFIG="ifs amip lpjg:fdbck"                                              
#  MYCONFIG="ifs amip tm5:chem,o3,ch4,aero"                                    
#  MYCONFIG="ifs amip tm5:co2"                                                 
#  MYCONFIG="ifs amip lpjg:fdbck tm5:co2"
#  
#  MYCONFIG="ifs nemo lim3 rnfmapper xios:detached oasis"                      
#  MYCONFIG="ifs nemo lim3 rnfmapper xios:detached oasis lpjg:fdbck"           
#  MYCONFIG="ifs nemo lim3 rnfmapper xios:detached oasis tm5:chem,o3fb,ch4fb,aerfb" 
#  MYCONFIG="ifs nemo lim3 rnfmapper xios:detached oasis lpjg:fdbck tm5:co2"   

cnfgxml=config-run.xml

#######################################################################
#          YOU SHOULD NOT HAVE TO CHANGE ANYTHING HEREAFTER           #
#######################################################################

source ./librunscript.sh
config=$MYCONFIG
mkdir -p out | true

# ----- parse and get info from xml
ec-conf -p ecmwf-cca-intel ${cnfgxml}

expn=$(get_ece_config_param.py ${cnfgxml} GENERAL EXP_NAME)
nifs=$(get_ece_config_param.py ${cnfgxml} IFS NUMPROC)     
nnem=$(get_ece_config_param.py ${cnfgxml} NEM NUMPROC)     
nxio=$(get_ece_config_param.py ${cnfgxml} XIO NUMPROC)     
ntmx=$(get_ece_config_param.py ${cnfgxml} TM5 NUMPROC_X)   
ntmy=$(get_ece_config_param.py ${cnfgxml} TM5 NUMPROC_Y)   
nlpj=$(get_ece_config_param.py ${cnfgxml} LPJG NUMPROC)    
ntm5=$(( ntmx*ntmy ))
adate=$(get_ece_config_param.py ${cnfgxml} GENERAL RUN_START_DATE)
edate=$(get_ece_config_param.py ${cnfgxml} GENERAL RUN_END_DATE)
run_start_date=${adate}

srcdir=$(get_ece_config_param.py ${cnfgxml} ecmwf-cca-intel ECEARTH_SRC_DIR )
forked=$(get_ece_config_param.py ${cnfgxml} ecmwf-cca-intel USE_FORKING )

# requires that you are in the PrgEnv-intel (used to compile the F90 ELPiN source)
if has_config nemo:elpin
then
    # tricky: need a ncdump that works with all resolution
    lmods=$(for mm in $(module -t list 2>&1| grep hdf5); do echo ${mm} | sed "s|(.*||"; done)
    for mm in $lmods; do module unload $mm; done 
    module load netcdf4/4.4.1

    nem_grid=$(get_ece_config_param.py ${cnfgxml} NEM GRID)
    ini_data_dir=$(get_ece_config_param.py ${cnfgxml} ecmwf-cca-intel INI_DATA_DIR )

    bathyfile=${ini_data_dir}/nemo/initial/${nem_grid}/bathy_meter.nc
    elpin=$(eval echo ${srcdir}/util/ELPiN/ELPiNv2.cmd)
    nem_res_hor=$(echo ${nem_grid} | sed 's:ORCA\([0-9]\+\)L[0-9]\+:\1:')
    jpns=($(${elpin} ${bathyfile} ${nnem}))
    onnem=$nnem
    nnem=${jpns[0]}
    echo; echo " Using ELPiN: switched from $onnem to $nnem processes for NEMO"

    # revert module setup
    module unload netcdf4/4.4.1
    for mm in $lmods; do module load $mm; done 
fi

ntot=0
mess="\nSubmit:"
has_config ifs      && mess=$mess" ifs(${nifs})"     && ntot=$(( ntot + nifs )) 
has_config nemo     && mess=$mess" + nemo(${nnem})"  && ntot=$(( ntot + nnem ))
has_config xios     && mess=$mess" + xios(${nxio})"  && ntot=$(( ntot + nxio ))
has_config ifs nemo && mess=$mess" + rnfmapper(1)"   && ntot=$(( ntot + 1    ))
has_config tm5      && mess=$mess" + tm5(${ntm5})"   && ntot=$(( ntot + ntm5 ))
has_config lpjg     && mess=$mess" + lpjg(${nlpj})"  && ntot=$(( ntot + nlpj ))
has_config amip     && mess=$mess" + amip(1)"        && ntot=$(( ntot + 1    ))
printf "$mess, exp=${expn} [model: ${srcdir}]\n"
printf "  from ${run_start_date} to $(eval echo ${edate})\n\n"

# ----- PBS directives. Models order matters: first NEMO and IFS
if $(has_config nemo)
then 
    tasks="${nxio}:${nnem}:${nifs}"
    threads="1:1:1"
else 
    tasks="${nifs}"
    threads="1"
fi

# then LPJ, TM5, AMIP
max_cores=$(( 1*36 )) # hyperthread = 1 or 2, MUST match value in
                      # platform/cca.job.tmpl - this is used only if lpjg is
                      # run (tests so far have not show any gain from setting
                      # hyperthread to 2)

if $(has_config lpjg)
then
    tasks=${tasks}":${nlpj}" && tpn=$(echo $threads | sed "s/1/${max_cores}/g")":5"
    threads=${threads}":1"
fi

has_config tm5 && tasks=${tasks}":${ntm5}" \
    && threads=${threads}":1" && [[ $tpn ]] && tpn=$tpn":${max_cores}"

has_config amip && tasks=${tasks}":1" \
    && threads=${threads}":1" && [[ $tpn ]] && tpn=$tpn":1"

# Add runoff
has_config nemo && tasks=${tasks}":1" \
    && threads=${threads}":1" && [[ $tpn ]] && tpn=$tpn":1"

[[ $tpn ]] && tpn='\n#PBS -l EC_tasks_per_node='$tpn

# ----- Write submit and run scripts
tgt_script=ec-${expn}.job

if $forked                      # Simple forking (all together)
then
    echo Use forking with $ntot

    sed -e "s|^#PBS -o .*|#PBS -o out/${expn}.$RANDOM.out.001|" \
        -e "s|^#PBS -l EC_total_tasks.*|#PBS -l EC_total_tasks=${ntot}|" \
        -e "s|^#PBS -l EC_threads_per_task.*|#PBS -l EC_threads_per_task=1|" \
        -e "s|./script.sh|./ece-${expn}.sh|" \
        -e "s|^#PBS -N cca.job|#PBS -N ec-${expn}.job|" \
	-e "s|^#PBS -M mail|#PBS -M $mailadress|" \
        <platform/ecmwf-cca.job.tmpl >$tgt_script

else                            # Not sharing nodes between models

        sed -e "s|^#PBS -o .*|#PBS -o out/${expn}.$RANDOM.out.001${tpn}|" \
        -e "s|^#PBS -l EC_total_tasks.*|#PBS -l EC_total_tasks=${tasks}|" \
        -e "s|^#PBS -l EC_threads_per_task.*|#PBS -l EC_threads_per_task=${threads}|" \
        -e "s|./script.sh|./ece-${expn}.sh|" \
        -e "s|^#PBS -N cca.job|#PBS -N ec-${expn}.job|" \
	-e "s|^#PBS -M mail|#PBS -M $mailadress|" \
        <platform/ecmwf-cca.job.tmpl >$tgt_script
fi

[[ -n $ACCOUNT ]] && \
    sed -i "s|^#PBS -l EC_billing.*|#PBS -l EC_billing_account=${ACCOUNT}|" $tgt_script || \
    sed -i "/^#PBS -l EC_billing.*/ d" $tgt_script

sed "s|^config=.*|config=\"${MYCONFIG}\"|" <ece-esm.sh >ece-${expn}.sh
chmod 744 ./ece-${expn}.sh

if [ $# -eq 1 ]
then
    qsub -W depend=afterok:$1 $tgt_script
else
    qsub $tgt_script
fi
