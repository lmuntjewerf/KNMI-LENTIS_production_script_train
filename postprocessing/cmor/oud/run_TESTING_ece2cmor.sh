#!/bin/bash

cd /perm/ms/nl/nklm/cmorize/ece2cmor3/ece2cmor3/scripts/submit-script-examples/
for j in {001..010}; do   ./submitVAREX-at-cca-ece2cmor-leg-job.sh  ifs  $(printf "%03d" $j) h011; done
for j in {001..010}; do   ./submitVAREX-at-cca-ece2cmor-leg-job.sh  nemo $(printf "%03d" $j) h011; done


