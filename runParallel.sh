#!/bin/bash
#
# Use 2 nodes, i.e. 2x32? cores, for 1 hour
#SBATCH -N 2 
#SBATCH -t 02:00:00

# Update the project if possible. 
#git pull

# Load the Matlab module
module load MATLAB/R2018b-nsc1 
module add gcc/8.2.0 

MATLAB='matlab -nodesktop -nodisplay -singleCompThread'
# The name of the Matlab script (without .m)
job=EstimateParameters()
now=$(date '+%Y%m%d-%H%M%S')

# Setup things first. 
${MATLAB} -r "Setup(); exit"

# Run main task. Note the explicit "exit" to exit Matlab.
for i in $(seq 1 256);do
  srun -N1 -n1  ${MATLAB} -r "${job}($RANDOM,'${now}');exit" > ./Log/${job}_${i}.log &
done
wait # needed to prevent the script from exiting before all Matlab tasks are done

# End of script
