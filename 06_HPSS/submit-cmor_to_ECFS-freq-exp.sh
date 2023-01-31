#!/usr/bin/env bash
# Laura Muntjewerf
#
# Run this script without arguments for examples how to call this script.
# 
# submit script to bring tar.gz files of cmorized output to ECFS
# following the ec-folder structer as created by:
#     /home/ms/nl/nklm/VAREX-LE_script_train/HPSS/ltape/make_ec_folders.sh
#
# This scripts requires two arguments:
#  1st argument: frequency of the cmor output
#  2nd argument: experiment name

if [ "$#" -eq 2 ]; then

  wall_clock_time=12:00:00    # Maximum estimated time of run

  FREQUENCY=$1
  EXP=$2 
  
  SCRIPT_LOCATION=/home/ms/nl/nklm/VAREX-LE_script_train/HPSS/ltape/cmor_by_freq_to_ECFS.sh

  # The directoy from where the submit scripts will be launched by qsub:
  running_directory=/home/ms/nl/nklm/VAREX-LE_script_train/HPSS/ltape/jobs_cmor_by_freq_to_ECFS/
  
  pbs_header='
#PBS -N cmor_totape-'${FREQUENCY}'-'${EXP}'
#PBS -q ns
#PBS -j oe
#PBS -o cmor_totape-'${FREQUENCY}'-'${EXP}'.out
#PBS -l walltime='${wall_clock_time}'
'

 job_name=cmor_totape-${FREQUENCY}-${EXP}.sh

 # This block of variables need to be checked and adjusted:
 definition_of_script_variables='
 FREQUENCY='${FREQUENCY}'
 EXP='${EXP}'
 SCRIPT_LOCATION='${SCRIPT_LOCATION}'
 '

 script_execution_call='
 bash $SCRIPT_LOCATION $FREQUENCY $EXP
 '

 # Creating the job submit script which will be submitted by qsub:

 echo "#! /bin/bash                                                                                " | sed 's/\s*$//g' >  ${job_name}
 echo "                                                                                            " | sed 's/\s*$//g' >> ${job_name}
 echo " ${pbs_header}                                                                              " | sed 's/\s*$//g' >> ${job_name}
 echo "                                                                                            " | sed 's/\s*$//g' >> ${job_name}
 echo " ${definition_of_script_variables}                                                          " | sed 's/\s*$//g' >> ${job_name}
 echo " ${script_execution_call}                                                                   " | sed 's/\s*$//g' >> ${job_name}
 echo "                                                                                            " | sed 's/\s*$//g' >> ${job_name}
 echo " echo                                                                                       " | sed 's/\s*$//g' >> ${job_name}
 echo " echo 'The ${job_name} job has finished.'                                                   " | sed 's/\s*$//g' >> ${job_name}
 echo " echo                                                                                       " | sed 's/\s*$//g' >> ${job_name}

 chmod uog+x ${job_name}

 mkdir -p ${running_directory}
 if [ ! -d ${running_directory} ]; then echo; echo -e "\e[1;31m Error:\e[0m"" the directory " '${running_directory}' " does not exist."; echo; exit 1;  fi
 mv -f ${job_name} ${running_directory}
 cd ${running_directory}

 # Submitting the job with qsub:
 qsub ${job_name}

 # Printing some status info of the job:
 echo
 echo ' The ' ${running_directory}${job_name} ' submit script is created and submitted. Monitor your job by:'
 echo '  qstat -u ' ${USER}
 echo

else
 echo
 echo '  Illegal number of arguments: the script requires two arguments:'
 echo '   1st argument: Frequency '
 echo '   2nd argument: Experiment'
 echo '  For instance:'
 echo '   ' $0 ' 3hr h010'
 echo '  Or use:'
 echo '   for i in {3hr,6hrPlev,6hrPlevPt,AERmon,Amon,CFday,Eday,Emon,LImon,Lmon,Oday,Ofx,Omon,SImon,day,fx}; do for j in {h010,h011}; do ' $0 ' $i $j; done; done'
fi



