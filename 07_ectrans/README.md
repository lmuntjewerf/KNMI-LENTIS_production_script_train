## Explanation ECtrans

### Concept

ECtrans is unattended file transfer between the ECMWF servers and the member state servers. 
You have to send the data from an ECMWF server, it is not possible retrieve it starting from a member state server. To be able to send to a member state workstation, you must create an association on the member state ecaccess gateway in which you designate a location (directory) on your workstation as the destination, see Intranet (as long as it is still possible). 
Ask Hans de Vries for further details to set this up. Also, I have a written documentation from Eva van der Kooij and Antonello Squintu that describes how to create such an association. 

### Steps
The LENTIS dataset is stored on ECFS, which is the HPSS of ECWMF. 
To get the data using ECtrans requires 2 steps. 
1: download the data from ECFS to ECgate $SCRATCH
2: transfer the data from ECgate $SCRATCH to your workstation with ECtrans

Step 1: log in on the member state ecaccess gateway respective website 
On the left is a menu, go to 'Browsing - ECfs files'
Once you have found the files you want, select them and at the bottom of the page click: 'Copy to ECscratch'

Step 2: log into ECgate via the terminal: ssh -Y <user>@ecaccess.ecmwf.int and choose 'ecgate' (this is phased out since decomissioning of CCA... check new protocol for hpc2020)
Then run the command/script in this folder with the files names you want to transfer. 




