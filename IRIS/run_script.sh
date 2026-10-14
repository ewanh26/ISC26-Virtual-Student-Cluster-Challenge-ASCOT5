#!/bin/bash
#SBATCH --job-name=sim-ascot5-sparc
#SBATCH --partition=iris
#SBATCH --nodes=4
##SBATCH --ntasks-per-node=28
##SBATCH --cpus-per-task=28
#SBATCH --time=04:00:00

# 28 cores/node

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module load intel/2023.2
module load compiler mkl
MPI=hpcx-2.25.1
module load $(echo $MPI | sed 's/x-/x\//')
export OMPI_CC=icc
module load hdf5/1.14.6-$MPI
module load python

cp ./inputs/1M_link ./inputs/1M.h5
echo Copied 1M SPARC input.
echo Running...
mpirun ./ascot5_main --in="./inputs/1M.h5" --out="./outputs/${SLURM_JOB_ID}.h5"

RUNTIME=$(sacct -j $SLURM_JOB_ID --format=Elapsed -X | grep -E -o '([0-9]+:){2}([0-9]+)')
echo $SLURM_JOB_ID,$SLURM_NNODES,$SLURM_NTASKS_PER_NODE,$OMP_NUM_THREADS,$RUNTIME>> ./ascot_runs.csv
echo Job info recorded.