#!/usr/bin/env bash
# Original by Thomas Reerink
# Adapted for KNMI-LENTIS by Laura Muntjewerf
#
# This script creates 2 bash scripts for an ensemble member speficically that check a number of metrics.  
# This scripts requires one arguments, namely the 4-digit ensemble member name.
# Run this script without arguments for examples how to call this script.
#
# With this script the validation instructions for the varex-simulations are generated.


 if [ "$#" -eq 1 ]; then
  k=${1:0:1}
  j=${1:1:2}
  i=${1:3:1}

  # The administration of the status of the validation:
  validated_runs=['h015']

  # The administration of the status of the removal of the ECE raw data:
  removed_raw_data=['none']

  output_file=validate-varex-simulation-${k}${j}${i}_1.sh
  output_file2=validate-varex-simulation-${k}${j}${i}_2.sh
  version=v20220601
  account='--account=proj-dutch_post'
  qos=''


  echo "                                                                                                                                 " | sed 's/\s*$//g'  > ${output_file}

  time_records="10"
  remove_pattern="*/00[2-9]"


  alias ${k}${j}${i}s="cd $SCRATCH/submit-ec-earth-3/branch-varex-${k}${j}${i}"
  alias ${k}${j}${i}r="cd $SCRATCH/ec-earth-3/branch-varex/${k}${j}${i}"
  alias ${k}${j}${i}c="cd $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-${k}${j}${i}/${k}${j}${i}/CMIP6/*MIP/KNMI/EC-Earth3/*/r*i*p5f1/"
  alias ${k}${j}${i}l="cd $SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-${k}${j}${i}/${k}${j}${i}/logs/"


  alias checkcmorised="grep ERR *|grep -v -e Oclim -e talknat -e dissicnat -e monC -e ncatice -e opa_grid_1point"
  alias sse='cd ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/submit-script-examples/'

  files_per_year=166
  nr_of_variables=174



  if [ "${k}" = "h" ]; then leading_digit=1 experiment_type=control                ; fi  # varex-control                   start at year 2000 (historical forcing)
  if [ "${k}" = "i" ]; then leading_digit=2 experiment_type=perturbed-soil-moisture; fi  # varex-perturbed-soil-moisture   start at year 2000 (historical forcing)
  if [ "${k}" = "j" ]; then leading_digit=3 experiment_type=perturbed-convection   ; fi  # varex-perturbed-convection      start at year 2000 (historical forcing)
  if [ "${k}" = "s" ]; then leading_digit=5 experiment_type=control                ; fi  # varex-control                   start at year 2075 (ssp245     forcing)
  if [ "${k}" = "t" ]; then leading_digit=6 experiment_type=perturbed-soil-moisture; fi  # varex-perturbed-soil-moisture   start at year 2075 (ssp245     forcing)
  if [ "${k}" = "u" ]; then leading_digit=7 experiment_type=perturbed-convection   ; fi  # varex-perturbed-convection      start at year 2075 (ssp245     forcing)

  if [ "${k}" = "h" ] || [ "${k}" = "i" ] || [ "${k}" = "j" ]; then mip=CMIP        experiment_name=historical experiment_name_2=historical time_range="2000 2009"; fi
  if [ "${k}" = "s" ] || [ "${k}" = "t" ] || [ "${k}" = "u" ]; then mip=ScenarioMIP experiment_name=ssp2-4.5   experiment_name_2=ssp245     time_range="2075 2084"; fi




  experiment_id=${k}${j}${i}
  member=${leading_digit}${j}${i}
  ec_earth_dir=$SCRATCH/ec-earth-3/branch-varex/${experiment_id}/output/
  filenumber_check_file=filenumber-check/filenumber-check-varex-simulations-${experiment_id}.txt
  cmorised_cmip6_dir=$SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-${experiment_id}/${experiment_id}/CMIP6/
  ripf=r${member}i${i}p5f1
  table_dir=${cmorised_cmip6_dir}/${mip}/KNMI/EC-Earth3/${experiment_name_2}/${ripf}/
  pbs_dir=${cmorised_cmip6_dir}/../../../../
  nctime_log_file=\${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/log-nctcck/${experiment_id}/nct*


  check_pbs="for i in \`find ${pbs_dir}/pbs-log-for-cmorising-${experiment_id}-*.out\`; do sed -e '0,/--ececonf/d' -e '0,/sh.epilog.ecmwf-INFO/!d' -e '/sh.epilog.ecmwf-INFO/d' -e '/^$/d' \${i}; done"

  echo experiment_id            = ${experiment_id}

  if [[ ${validated_runs[*]} =~ ${experiment_id} ]]
  then
   validation_status='Validated'
  else
   validation_status=''
  fi

  if [[ ${removed_raw_data[*]} =~ ${experiment_id} ]]
  then
   removal_status='. The EC-Earth3 raw output data has been removed.'
  else
   removal_status=''
  fi


  echo "#!/bin/bash                                                                                                                                        " | sed 's/\s*$//g' >> ${output_file}
  echo "shopt -s expand_aliases # to make aliasses work in a bash script                                                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo "source ~/.user_bashrc                                                                                                                              " | sed 's/\s*$//g' >> ${output_file}
  echo "                                                                                                                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo "                                                                                                                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo " # Validating the ${experiment_id} cmorisation. Status = ${validation_status}${removal_status}                                                     " | sed 's/\s*$//g' >> ${output_file}
  echo " ${experiment_id}l; checkcmorised;                                                                                                                 " | sed 's/\s*$//g' >> ${output_file}
  echo " ls -1l ${experiment_id}-nemo-*[0-9].cmor.log | wc -l; ls -1l ${experiment_id}-nemo-*[0-9].log | wc -l;                                            " | sed 's/\s*$//g' >> ${output_file}
  echo " ls -1l ${experiment_id}-ifs-*[0-9].cmor.log  | wc -l; ls -1l ${experiment_id}-ifs-*[0-9].log  | wc -l                                             " | sed 's/\s*$//g' >> ${output_file}
  echo " sse                                                                                                                                               " | sed 's/\s*$//g' >> ${output_file}
  echo " ${check_pbs}                                                                                                                                      " | sed 's/\s*$//g' >> ${output_file}
  echo " ${check_pbs} | wc -l                                                                                                                              " | sed 's/\s*$//g' >> ${output_file}
  echo " mkdir -p filenumber-check                                                                                                                         " | sed 's/\s*$//g' >> ${output_file}
  echo " ../data-qa/scripts/files-per-year.sh ${time_range} ${cmorised_cmip6_dir} > ${filenumber_check_file}                                               " | sed 's/\s*$//g' >> ${output_file}
  echo " wc -l ${filenumber_check_file}; grep ${files_per_year} ${filenumber_check_file} | wc -l                                                           " | sed 's/\s*$//g' >> ${output_file}
  echo " ls -1 -d ${table_dir}/*/* | wc -l | grep -v -e ${nr_of_variables}                                                                                 " | sed 's/\s*$//g' >> ${output_file}
  echo " find ${cmorised_cmip6_dir} -empty                                                                                                                 " | sed 's/\s*$//g' >> ${output_file}
  echo " find ${cmorised_cmip6_dir} -type f ! -name '*.nc'                                                                                                 " | sed 's/\s*$//g' >> ${output_file}
  echo " find ${cmorised_cmip6_dir} -name '*_${ripf}_g[rn][a-zA-Z0-9]*'                                                                                    " | sed 's/\s*$//g' >> ${output_file}
  echo " ../data-qa/scripts/versions.sh -l ${cmorised_cmip6_dir}                                                                                           " | sed 's/\s*$//g' >> ${output_file}
  echo " ../data-qa/scripts/versions.sh -v ${version} -m ${cmorised_cmip6_dir}                                                                             " | sed 's/\s*$//g' >> ${output_file}
  echo " ../data-qa/scripts/versions.sh -l ${cmorised_cmip6_dir}                                                                                           " | sed 's/\s*$//g' >> ${output_file}
  echo " for i in \`find ${table_dir} -type d -name ${version}\`; do ls -1 \${i} | wc -l | grep -v -e ${time_records}; done                                " | sed 's/\s*$//g' >> ${output_file}
  echo " activateece2cmor3; sse                                                                                                                            " | sed 's/\s*$//g' >> ${output_file}
  echo " ../data-qa/scripts/sftof.py ${table_dir}/Ofx/sftof/gn/${version}/sftof_Ofx_EC-Earth3_${experiment_name_2}_*_gn.nc                                 " | sed 's/\s*$//g' >> ${output_file}
  echo " rm -f ${table_dir}/Ofx/sftof/gn/${version}/sftof_Ofx_EC-Earth3_${experiment_name_2}_*_gn.nc.bak                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo " cd \${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/data-qa/nctime/                                                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo " ./submit-script-for-nctime-on-cca.sh   ${cmorised_cmip6_dir} ${experiment_id}                                                                     " | sed 's/\s*$//g' >> ${output_file}
  echo " ./submit-script-for-checksum-on-cca.sh ${cmorised_cmip6_dir} ${experiment_id}                                                                     " | sed 's/\s*$//g' >> ${output_file}
  echo "                                                                                                                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo "                                                                                                                                                   " | sed 's/\s*$//g' >> ${output_file}
  echo "                                                                                                                                                   " | sed 's/\s*$//g' >> ${output_file}

  cod u+x ${output_file}


  echo "#!/bin/bash                                                                                                                                        " | sed 's/\s*$//g' >> ${output_file2}
  echo "shopt -s expand_aliases # to make aliasses work in a bash script                                                                                   " | sed 's/\s*$//g' >> ${output_file2}
  echo "source ~/.user_bashrc                                                                                                                              " | sed 's/\s*$//g' >> ${output_file2}
  echo "                                                                                                                                                   " | sed 's/\s*$//g' >> ${output_file2}
  echo " cat ${nctime_log_file}                                                                                                                            " | sed 's/\s*$//g' >> ${output_file2}
  echo " grep -e broken -e overlap -e error ${nctime_log_file} |sed -e 's/^.*log-nctcck.//' -e 's/.nct..k-.*log:/: /'                                      " | sed 's/\s*$//g' >> ${output_file2}
  echo " more ${cmorised_cmip6_dir}/../sha256sum-checksum-CMIP6-${experiment_id}.txt | wc -l; more ${nctime_log_file} | grep scanned                       " | sed 's/\s*$//g' >> ${output_file}
  echo " ls -ld ${cmorised_cmip6_dir}/../                                                                                                                  " | sed 's/\s*$//g' >> ${output_file2}


   chmod u+x ${output_file2}



 else
  echo
  echo '  Illegal number of arguments: the script requires one arguments, e.g.:'
  echo '   ' ${0} h010 ''
  echo
 fi
