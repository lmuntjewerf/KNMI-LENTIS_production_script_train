#! /bin/bash


#PBS -N c-ifs-001-s110
#PBS -q nf
#PBS -j oe
#PBS -o pbs-log-for-cmorising-s110-ifs-001.out
#PBS -l walltime=2:00:00
#PBS -l EC_hyperthreads=1
#PBS -l EC_total_tasks=1
#PBS -l EC_threads_per_task=18
##PBS -l EC_billing_account=${EC_billing_account}
##PBS -W depend=afterok:<JOB_ID_OF_PREVIOUS_DEPENDENCY_JOB>


 source $SCRATCH/mamba/etc/profile.d/conda.sh
 conda activate ece2cmor3
 export HDF5_USE_FILE_LOCKING=FALSE
 export UVCDAT_ANONYMOUS_LOG=false

 if ! type ece2cmor > /dev/null; then echo -e "\e[1;31m Error:\e[0m"" ece2cmor is not activated." ;fi


 cd ${PERM}/cmorize/ece2cmor3/; echo; git log |head -n 1 | sed -e "s/^/Using /" -e "s/$/ for/"; ece2cmor --version;                                           cd $SCRATCH/cmorisation/;



 COMPONENT=ifs
 LEG=001

 EXP=s110
 ECEDIR=$SCRATCH/ec-earth-3/branch-varex/s110/output/ifs/001
 ECEMODEL=EC-EARTH-AOGCM
 METADATA=$SCRATCH/submit-ec-earth-3/branch-varex-s110/ctrl/output-control-files/varex-control-ScenarioMIP-ssp245/metadata-cmip6-CMIP-historical-EC-EARTH-AOGCM-ifs-template.json
 TEMPDIR=$SCRATCH/cmorisation/temp-cmor-dir/s110/ifs/001
 VARLIST=$SCRATCH/submit-ec-earth-3/branch-varex-s110/ctrl/output-control-files/varex-control-ScenarioMIP-ssp245/varex-data-request-varlist-EC-Earth3.json
 ODIR=$SCRATCH/cmorisation/cmorised-results/cmor-VAREX-cmip-s110/s110


 if [ ! -d "$ECEDIR"       ]; then echo -e "\e[1;31m Error:\e[0m"" EC-Earth3 data output directory: " $ECEDIR " does not exist. Aborting job: " $0 >&2; exit 1; fi
 if [ ! "$(ls -A $ECEDIR)" ]; then echo -e "\e[1;31m Error:\e[0m"" EC-Earth3 data output directory: " $ECEDIR " is empty. Aborting job:" $0 >&2; exit 1; fi


 mkdir -p $ODIR
 if [ -d $TEMPDIR ]; then rm -rf $TEMPDIR; fi
 mkdir -p $TEMPDIR

 echo
 echo 'The cmorise-s110-ifs-001.sh job will run:'
 echo ece2cmor $ECEDIR --exp $EXP  --ececonf $ECEMODEL  --$COMPONENT  --meta $METADATA  --varlist $VARLIST  --tmpdir $TEMPDIR  --odir $ODIR  --npp 18  --overwritemode replace  --skip_alevel_vars  --log
 echo


 ece2cmor $ECEDIR --exp               $EXP      \
                  --ececonf           $ECEMODEL \
                  --$COMPONENT                  \
                  --meta              $METADATA \
                  --varlist           $VARLIST  \
                  --tmpdir            $TEMPDIR  \
                  --odir              $ODIR     \
                  --npp               18        \
                  --overwritemode     replace   \
                  --skip_alevel_vars            \
                  --log



 mkdir -p $ODIR/logs
 mv -f $EXP-$COMPONENT-$LEG-*.log $ODIR/logs/



 echo
 echo 'The cmorise-s110-ifs-001.sh job has finished.'
 echo
