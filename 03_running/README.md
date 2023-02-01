## Explanation running the simulations

### Concept of set-up
Each simulation has its own submit directory. These are set-up earlier, see the preprocessing folder. 

### Use
Go to the respective submit directory, and submit the simulation by typing in the command line: 
`./wrapper-esm-at-cca-restart.sh`. See the `wrapper_esm.sh` as example for ECMWF HPC cca. 

### Notes

Changes so that a run job will send an email when beginning, ending and aborting: 
1.  Changes to the ..runtime/classic/platform/ecmwf-cca.job.tmpl: 
```
	./ecmwf-cca.job.tmpl: #PBS -m abe
	./ecmwf-cca.job.tmpl: #PBS -M mail
```
2.  Changes to the ..runtime/classic/wrapper_esm.sh:
```
	./wrapper_esm.sh: mailadress=<EMAIL-ADDRESS> # PBS sends email for job abe (abort/begin/end)
	./wrapper_esm.sh:	-e "s|^#PBS -M mail|#PBS -M $mailadress|" \
```

