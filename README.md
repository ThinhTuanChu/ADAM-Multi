
          ##############################################################
          # ADAM-multi: Software to simulate complex breeding programs #
          #                for animals and plants                      #
          #                                                            #
          # By Thinh Tuan Chu, QGG, Aarhus University, Denmark         #
          ##############################################################

Introduction and theories behind this software can be found here:
Chu TT and Jensen J (2025) ADAM-multi... Front. Genet. 16:1513615. doi: 10.3389/fgene.2025.1513615
Please contact the author (chu.thinh @ qgg.au.dk remove space) for further help with installation 
& manual. In general, this program uses old fashion input parameters, thus a bit difficult to use.

This excutable program was compiled by ifort using Intel OneAPI. To run this program, it needs
ifort to be installed, and MKL library, and some other (optional) programs (DMU, eva, invhmatrix...).
To download DMU (used for EBV prediction. Free for research purposes): 
https://dmu.ghpc.au.dk/dmu/DMU/Linux/Current/ 

This program is assumed to be put in folder: 
'~/ADAMMulti/'

DMU can be download from:
https://dmu.ghpc.au.dk/dmu/DMU/Linux/Current/
and be put in folder: 
'~/ADAMMulti/dmuv6/R5.6-EM64T/bin/'

Environment $SLURM_SUBMIT_DIR or $ADAM_SUBMIT_DIR is the folder where contains input files.

Examples are provided. To run the program using the example provided, 
use aslurm.sh (submit to a queue) or arun.sh (run directly, or on interactive)
Use example 1 to test the program if installed correctly.
Example 2, and 3 call other program to calculate genomic relationship matrices & estimate breeding values.


This program is free and comes with ABSOLUTELY NO WARRANTY.
You are welcome to use and redistribute it.
