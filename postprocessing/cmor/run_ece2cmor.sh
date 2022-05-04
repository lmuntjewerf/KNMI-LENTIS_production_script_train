#! /usr/bin/env bash

set -ex

# activatie python packages
eval activatemamba
eval which mamba

# activate python environment for ece2cmor
eval activateece2cmor3

# cd to place of execution
cd ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/submit-script-examples/

declare -a experiments
experiments=(s033)
#experiments=(h140 h020 h032 h023)
#experiments=(s110)
#experiments=(s110 s123 h120 h112 h124)
#experiments=(s150 s151 s152 s153 s154 s160 s161 s162 s163 s164)
#experiments=(h150 h151 h152 h153 h154 h160 h161 h162 h163 h164)
#experiments=(h130 h131 h132 h133 h134 h140 h141 h142 h143 h144 s130 s131 s132 s133 s134 s140 s141 s142 s143 s144)
#experiments=(h051 h052 h053 s013 s033 s043)
#experiments=(h110 h111 h112 h113 h114 h120 h121 h122 h123 h124 s110 s111 s112 s113 s114 s120 s121 s122 s123 s124)
#experiments=(h090 h091 h092 h093 h094 h100 h101 h102 h103 h104 s090 s091 s092 s093 s094 s100 s101 s102 s103 s104)
#experiments=(s070 s071 s072 s073 s074 s080 s081 s082 s083 s084)
#experiments=(h070 h071 h072 h073 h074 h080 h081 h082 h083 h084 s070 s071 s072 s073 s074 s080 s081 s082 s083 s084)
#experiments=(h054 h060 h061 h062 h063 h064)
#experiments=(s050 s051 s052 s053 s054 s060 s061 s062 s063 s064)
#experiments=(h014 h024 h034 h044 s014 s024 s034 s044 s041 s042 s043)
#experiments=(s023 s033)
#experiments=(h013 h023 h033 h043 h041 h042 h050 h051 h052 h053 s013 s023 s033)
#experiments=(h021 h022 h031 h032 h040 s021 s022 s031 s032 s040)
#experiments=(h012 h030 s011 s012 s020 s030)
#experiments=(h011)

for experiment in ${experiments[@]}; do
  for j in {001..010}; do # {001..010}; do 
    ./submitVAREX-at-cca-ece2cmor-leg-job.sh  ifs  $(printf "%03d" $j) ${experiment}; 
  done
  for j in {001..010}; do 
    ./submitVAREX-at-cca-ece2cmor-leg-job.sh  nemo $(printf "%03d" $j) ${experiment}; 
  done
done

echo "output of cmorization will be here: ${SCRATCH}/cmorisation/cmorised-results/"




