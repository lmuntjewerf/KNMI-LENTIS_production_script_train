#! /usr/bin/env bash

set -ex

ic=16
expletter=D
startyear=2000


config=config-run.xml
ecetempl=ece-esm.sh.tmpl
wrapper=wrapper_esm.sh
rundir=/perm/ms/nl/nklm/knmi23-dutch-climate-scenarios/runtime/classic/

# ========== set the deterministic run (no SPPT)
componentconfig='"ifs nemo lim3 rnfmapper xios:detached oasis"'
expname="$expletter"d"$ic"

sed -i "29s/=.*/=$componentconfig/" $rundir/$wrapper
sed -i  "52s_<Value>....</Value>_<Value>$expname</Value>_"  $rundir/$config
sed -i  "58s_<Value>....-01-01</Value>_<Value>$startyear-01-01</Value>_"  $rundir/$config
#
sed -i  "13s/ic_number=../ic_number=$ic/" $rundir/$ecetempl
sed -i  "15s/startyear=..../startyear=$startyear/" $rundir/$ecetempl
echo 'ecetempl: '$rundir/$ecetempl
echo 'config: '$rundir/$config
echo 'wrapper to submit: '$rundir/$wrapper

cd $rundir
./wrapper_esm.sh

# ========== now start setting the SPPT runs 
componentconfig='"ifs nemo lim3 rnfmapper xios:detached oasis sppt"'
sed -i "29s/=.*/=$componentconfig/" $rundir/$wrapper

for ifs_ensemble_forecast_number in $(seq -f "%01g" 0 4); do
  expname="$expletter""$seed""$ic"
  sed -i  "52s_<Value>....</Value>_<Value>$expname</Value>_"  $rundir/$config
  #sed -i  "14s/seed=./seed=$seed/" $rundir/$ecetempl #dit werkt niet, de variabele ifs_ensemble_forecast_number moet veranderd worden, zie hieronder
  #sed -i  "30s/ifs_ensemble_forecast_number=./ifs_ensemble_forecast_number=$seed/" $rundir/$wrapper #dit werkt ook niet. De var ifs_ensemble_forecast_number moet veranderd worden in de ECETEMPL!!
  sed -i "12s/ifs_ensemble_forecast_number=./ifs_ensemble_forecast_number=$ifs_ensemble_forecast_number/" $rundir/$ecetemp 
  cd $rundir
  ./wrapper_esm.sh
done


