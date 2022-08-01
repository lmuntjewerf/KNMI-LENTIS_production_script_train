#! /usr/bin/env bash

# written by Laura Muntjewerf

#set -ex

# activatie python packages
eval activatemamba
eval which mamba

# activate python environment for ece2cmor
eval activateece2cmor3

# cd to place of execution
#cd ${PERM}/cmorize/ece2cmor3/ece2cmor3/scripts/submit-script-examples/
cd /home/ms/nl/nklm/VAREX-LE_script_train/postprocessing/cmor

declare -a experiments
#experiments=(h150 h151 h152 h153 h154 h160 h161 h162 h163 h164 s032 s154 s160 s161 s162 s163 s164)
#experiments=(s032 s084 s130 s131 s132 s133 s134 s140 s141 s142 s143 s144 s150 s151 s152 s153)
#experiments=(h130 h131 h132 h133 h134 h140 h141 h142 h143 h144 s123 s124)
#experiments=(h110 h111 h112 h113 h114 h120 h121 h122 h123 h124 s110 s111 s112 s113 s114 s120 s121 s122)
#experiments=(s053 s070 s084)
#experiments=(h080 h081 h082 h083 h084 h090 h091 h092 h093 h094 h100 h101 h102 h103 h104)
#experiments=(s053 s070 s084 s030 s032)
#experiments=(s081 s082 s083 s084 s090 s091 s092 s093 s094 s100 s101 s102 s103 s104 s110 s111 s112 s113 s114)
#experiments=(s050 s051 s052 s053 s054 s060 s061 s062 s063 s064 s070 s071 s072 s073 s074)
#experiments=(s010 h050 h051 h052 h053 h054 h060 h061)
#experiments=(h062 h063 h064 h070 h071 h072 h073 h074)
experiments=(s032)

#experiments=(h023 h024 h030 h031 h032 h033 h034 h040 h041 h042 h043 h044) 
#experiments=(s010 s011 s012 s013 s014 s020 s021 s022 s023 s024 s030 s031 s032 s033 s034 s040 
#experiments=(s041 s042 s043 s044)
#experiments=(s010 s011 s012 s013 s014 s020 s021 s022 s023 s024 h011 h012 h013 h014 h020 h021 h022 h023 h024)
#experiments=(h010)
#experiments=(h013 h014 h020 h021 h022 s010 s011 s012 s014)
#experiments=(s147 s148)
#experiments=(h169 s066 s145 s146 s147 s148 s149 s155 s156 s157 s158 s159 s165 s166 s167 s168 s169)
#experiments=(s135 s136 s137 s138 s139)
#experiments=(h149)
#experiments=(h148 h155 h156 h157 h158 h159 h165 h166 h167 h168)
#experiments=(h135 h136 h137 h138 h139 h145 h146 h147 h148 h149)
#experiments=(h115 h116 h117 h118 h119 h125 h126 h127 h128 h129 s115 s116 s117 s118)
#experiments=(s119 s125 s126 s127 s128 s129 s057 s059)
#experiments=(s086 h058 h067)
#experiments=(s097 s107)
#experiments=(s066)
#experiments=(h095 h096 h097 h098 h099 h105 h106 h107 h108 h109)
#experiments=(s095 s096 s097 s098 s099 s105 s106 s107 s108 s109)
#experiments=(h075 h076 h077 h078 h079 h085 h086 h087 h088 h089)
#experiments=(h039)
#experiments=(s055 s056 s057 s058 s059 s065 s066 s067 s068 s069 s075 s076 s077 s078 s079 s085 s087 s088 s089)
#experiments=(h055 h056 h057 h058 h059 h065 h066 h067 h068 h069)
#experiments=(s035 s036 s037 s038 s039 s045 s046 s047 s048 s049)
#experiments=(h035 h036 h037 h038 h039 h045 h046 h047 h048 h049 s035 s036 s037 s038 s039 s045 s046 s047 s048 s049)
#experiments=(s015)
#experiments=(h019 s015)
#experiments=(h015 h016 h017 h018 h025 h026 h027 h028 h029 h015 s016 s017 s018 s019 s025 s026 s027 s028 s029)
#experiments=(s033)
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
  for j in {001..010}; do 
    ./submitVAREX-at-cca-ece2cmor-leg-job.sh  ifs  $(printf "%03d" $j) ${experiment}; 
  done
  #for j in {001..010}; do 
  #  ./submitVAREX-at-cca-ece2cmor-leg-job.sh  nemo $(printf "%03d" $j) ${experiment}; 
  #done
done

echo "output of cmorization will be here: ${SCRATCH}/cmorisation/cmorised-results/"




