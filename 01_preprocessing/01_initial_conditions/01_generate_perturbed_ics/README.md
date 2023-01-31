## Generating the perturbed initial condition files

We apply micro perturbations to the 16 parent inital condition files. This is done with the `01_perturb_var_eccodes.py` script written by Omar Bellprat (BSC). 

We do this for all 16 ICs for the two time slices: the `01_perturb_var_eccodes.py` script is called from the runscript `02_run_perturb_all.sh`. 

The runscript `02_run_perturb_all.sh` is submitted as a batch job `03a_submit.pbs`. The HPC environment is detailed in `03b_hpc_env.txt`