# assuming current folder has input files
ADAM_SUBMIT_DIR=$PWD
# make a temporary folder for running. A random name of the folder is generated.
TMPDIR=$ADAM_SUBMIT_DIR/$(cat /dev/urandom | tr -dc A-Za-z | head -c 8)
export TMPDIR ADAM_SUBMIT_DIR
mkdir -p $TMPDIR
cd $TMPDIR
pwd
 
echo Job started at $(date '+%d_%m_%y_%H_%M_%S')
 
ulimit -s unlimited

# load environments and library for running. Change directories to correct ones.
source /opt/intel/oneapi/setvars.sh
sharedlibadd=/opt/intel/oneapi/compiler/2024.0/lib
if [ -d "$sharedlibadd" ] && [[ ":$LD_LIBRARY_PATH:" != *":$sharedlibadd:"* ]]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$sharedlibadd
fi

# Adam Program
cp -f ~/ADAMMulti/adam2720 adam
 
echo Running adam
./adam > $ADAM_SUBMIT_DIR/adamlog.log
 
echo adam completed
 
#=========================================================================#
#                  Cleanup:  DO NOT REMOVE OR CHANGE                      #
#=========================================================================#
 
cd $ADAM_SUBMIT_DIR
 
rm -rf $TMPDIR
 
echo Job completed at $(date '+%d_%m_%y_%H_%M_%S')
