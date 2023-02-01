#!/usr/bin/env bash
# Thomas Reerink
#
# Run this script without arguments for examples how to call this script.
#
# This script sets all required changes in the varex production branch runtime directory for all the EC-Earth3 output
# configuration and its cmorisation. The script covers the historical (year 2000-2010) & ssp2-4.5 (year 2075-2085)
# runs for a control, a perturbed-soil-moisture & perturbed-convection set of ensembles.
#

if [ "$#" -eq 1 ]; then

 new_experiment_id=$1
 experiment_code=${new_experiment_id:(0):(1)}
 member_code=${new_experiment_id:(1):(2)}
 member_code_single_digit=${new_experiment_id:(2):(1)}
 perturbed_initial_state=${new_experiment_id:(3):(4)}

 if [ "${experiment_code}" = "h" ]; then new_experiment_name=historical leading_digit=1 experiment_type=control                ; fi  # varex-control                   start at year 2000 (historical forcing)
 if [ "${experiment_code}" = "i" ]; then new_experiment_name=historical leading_digit=2 experiment_type=perturbed-soil-moisture; fi  # varex-perturbed-soil-moisture   start at year 2000 (historical forcing)
 if [ "${experiment_code}" = "j" ]; then new_experiment_name=historical leading_digit=3 experiment_type=perturbed-convection   ; fi  # varex-perturbed-convection      start at year 2000 (historical forcing)
 if [ "${experiment_code}" = "s" ]; then new_experiment_name=ssp245     leading_digit=5 experiment_type=control                ; fi  # varex-control                   start at year 2075 (ssp245     forcing)
 if [ "${experiment_code}" = "t" ]; then new_experiment_name=ssp245     leading_digit=6 experiment_type=perturbed-soil-moisture; fi  # varex-perturbed-soil-moisture   start at year 2075 (ssp245     forcing)
 if [ "${experiment_code}" = "u" ]; then new_experiment_name=ssp245     leading_digit=7 experiment_type=perturbed-convection   ; fi  # varex-perturbed-convection      start at year 2075 (ssp245     forcing)

 if [ ${member_code} -lt 10 ]; then member=${member_code_single_digit}; else member=${member_code}; fi

 echo ' new_experiment_id        =' ${new_experiment_id}
 echo ' experiment_code          =' ${experiment_code}
 echo ' member_code              =' ${member_code}
 echo ' member_code_single_digit =' ${member_code_single_digit}
 echo ' member                   =' ${member}
 echo ' perturbed_initial_state  =' ${perturbed_initial_state}
 echo ' leading_digit            =' ${leading_digit}
 # Bash (little weard) string selection can be tested with:
 #  new_experiment_id=h129; echo ${new_experiment_id:(2):(1)}

 svn revert config-run.xml
 svn revert ctrl/output-control-files/varex-*/metadata-cmip6-*-template.json
 svn revert ece-esm.sh.tmpl
 svn revert platform/ecmwf-cca-intel.xml

 sed -i -e 's/"realization_index":            "."/"realization_index":            "'${leading_digit}${member_code}${perturbed_initial_state}'"/' \
        -e 's/"initialization_index":         "."/"initialization_index":         "'${perturbed_initial_state}'"/' \
        -e 's/"parent_variant_label":         "r.i1p.f1"/"parent_variant_label":         "r'${member}'i1p5f1"/' ctrl/output-control-files/varex-${experiment_type}-*-${new_experiment_name}/metadata*
 sed -i -e '/EXP_NAME/!b;n;n;n;c\            <Value>'${new_experiment_id}'</Value>' config-run.xml

# This is currently organised by additional output control files:
#if [ "${experiment_code}" = "i" ] || [ "${experiment_code}" = "t" ]; then
# sed -i -e 's/"physics_index":                "."/"physics_index":                "51"/' ctrl/output-control-files/varex-${experiment_type}-*-${new_experiment_name}/metadata*
# sed -i -e 's/"variant_info.*/"variant_info":                 "The p51 label refers to the fact that for this experiment the rtc5 retune parameter set has been used like in p5 experiments and in addition a soil moisture perturbation is applied."/' ctrl/output-control-files/varex-${experiment_type}-*-${new_experiment_name}/metadata*
#fi
#if [ "${experiment_code}" = "j" ] || [ "${experiment_code}" = "u" ]; then
# sed -i -e 's/"physics_index":                "."/"physics_index":                "52"/' ctrl/output-control-files/varex-${experiment_type}-*-${new_experiment_name}/metadata*
# sed -i -e 's/"variant_info.*/"variant_info":                 "The p52 label refers to the fact that for this experiment the rtc5 retune parameter set has been used like in p5 experiments and in addition a convection perturbation is applied."/' ctrl/output-control-files/varex-${experiment_type}-*-${new_experiment_name}/metadata*
#fi

 sed -i -e 's/ic_exp_name=h010/ic_exp_name='${experiment_code}${member_code}${perturbed_initial_state}'/' ece-esm.sh.tmpl

 if [ "${experiment_code}" = "s" ] || [ "${experiment_code}" = "u" ] || [ "${experiment_code}" = "t" ]; then
  sed -i -e '/RUN_START_DATE/!b;n;n;n;c\            <Value>2075-01-01</Value>' config-run.xml
  sed -i -e '/CMIP6_SCENARIO/!b;n;n;n;c\            <Value>SSP2-4.5</Value>' config-run.xml
 fi

 if [ "${experiment_code}" != "h" ] && [ "${experiment_code}" != "s" ]; then
 #sed -i -e '/ECEARTH_SRC_DIR/!b;n;n;n;c\            <Value>${HOME}/ec-earth-3/branch-varex-perturbed-soil-moisture/sources</Value>' platform/ecmwf-cca-intel.xml
  sed -i -e 's/branch-varex-control/branch-varex-'${experiment_type}'/' platform/ecmwf-cca-intel.xml
 fi

 svn stat

 else
 echo
 echo ' Illegal number of arguments: the script requires one argument: An experiment ID. Run e.g. like:'
 echo ' ' $0 'h010   # h010-h169 For configuring the historical (h01-h16) members 01-16 with perturbed initial states 0-9'
 echo ' ' $0 'i010   # i010-i169 For configuring the historical (h01-h16) members 01-16 with perturbed initial states 0-9'
 echo ' ' $0 'j010   # j010-j169 For configuring the historical (h01-h16) members 01-16 with perturbed initial states 0-9'
 echo ' ' $0 's010   # s010-s169 For configuring the ssp2-4.5   (s01-s16) members 01-16 with perturbed initial states 0-9'
 echo ' ' $0 't010   # t010-t169 For configuring the ssp2-4.5   (s01-s16) members 01-16 with perturbed initial states 0-9'
 echo ' ' $0 'u101   # u010-u169 For configuring the ssp2-4.5   (s01-s16) members 01-16 with perturbed initial states 0-9'
 echo
fi



# # Setup the h010-t169 experiments (control historical starting at year 2000 upto perturbed convection ssp245 at year 2075 for their 9 perturbed intial states):

# # Set some aliases/functions:
# function svns()  { svn stat | grep -v "^?" ; }
# function svncleannonversioned() { svn stat --no-ignore | grep -v -e svn-clean-non-versioned.sh | sed -e "s/?      /rm -rf /" -e "s/I      /rm -rf /"  | grep "rm -rf" > svn-clean-non-versioned.sh ; chmod uog+x svn-clean-non-versioned.sh ; ./svn-clean-non-versioned.sh ; rm -f svn-clean-non-versioned.sh ; }

# # Check first that the directory which will be copied is update and without changes:
# submit_dir_ece=${PERM}/submit-ec-earth-3
# svn checkout https://svn.ec-earth.org/ecearth3/branches/projects/varex/runtime/classic ${submit_dir_ece}/branch-varex-h010
# cd ${submit_dir_ece}/branch-varex-h010
# svns; svn info; svn update

# cd ${submit_dir_ece}
# for k in {h,i,j,s,u,t}; do
#  for j in {01..16}; do
#   for i in {0..9}; do
#    rsync -a branch-varex-h010/ branch-varex-${k}${j}${i}
#    cd branch-varex-${k}${j}${i}
#    svncleannonversioned
#    ./set-ensemble-member-changes.sh ${k}${j}${i}
#    cd ../
#   done
#  done
# done