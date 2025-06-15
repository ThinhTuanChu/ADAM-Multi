#!/bin/bash
#SBATCH -p ghpc                  # Name of the queue
#SBATCH -J histogenom            # job name
#SBATCH --mem=20G                # Memory in MiB(10 GiB = 10 * 1024 MiB)
#SBATCH -t 100:00:00             # Job max time - Format = MM or MM:SS or HH:MM:SS or DD-HH or DD-HH:MM
#SBATCH -N 1                      # number of nodes
#SBATCH -n 2                      # number of cores
#SBATCH --output=slurm_%A.out     # STDOUT
#SBATCH --error=slurm_%A.err      # STDERR
#SBATCH --export=ALL

# make a temporary folder for running. A random name of the folder is generated.
TMPDIR=$SLURM_SUBMIT_DIR/$(cat /dev/urandom | tr -dc A-Za-z | head -c 8)
export TMPDIR
mkdir -p $TMPDIR
cd $TMPDIR
pwd
 
echo Job started at $(date '+%d_%m_%y_%H_%M_%S')
echo Job submitted to Node: $SLURM_JOB_NODELIST from $SLURM_SUBMIT_HOST . Number of cores assigned: $SLURM_NTASKS
echo Submission directory $SLURM_SUBMIT_DIR
 
ulimit -s unlimited
export OMP_NUM_THREADS=$SLURM_NTASKS

# load environments and library for running. Change directories to correct ones.
source /opt/intel/oneapi/setvars.sh
sharedlibadd=/opt/intel/oneapi/compiler/2024.0/lib
if [ -d "$sharedlibadd" ] && [[ ":$LD_LIBRARY_PATH:" != *":$sharedlibadd:"* ]]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$sharedlibadd
fi

# Adam Program
cp -f ~/ADAMMulti/adam2720 adam
 
echo Running adam
./adam > $SLURM_SUBMIT_DIR/adamlog.log
 
echo adam completed
 
#=========================================================================#
#                  Cleanup:  DO NOT REMOVE OR CHANGE                      #
#=========================================================================#
 
cd $SLURM_SUBMIT_DIR
 
rm -rf $TMPDIR
 
echo Job completed at $(date '+%d_%m_%y_%H_%M_%S')
