#!/bin/bash
#SBATCH --job-name=sim-ascot5_sparc
#SBATCH --nodes=4
##SBATCH --ntasks-per-node=4
#SBATCH --gpus-per-task=4
#SBATCH --partition=short
#SBATCH --account=r250119
#SBATCH --time=10:00:00
#SBATCH --mem=64G
#SBATCH --constraint=armgpu

# 4 gpus/node

module use /gpfs/projet/r250119/tools/nvhpc/modulefiles
module load nvhpc-hpcx-cuda12/26.1
module load hdf5-1.14.6

cp ./inputs/1M_link ./inputs/1M.h5
echo Copied 1M SPARC input.
echo Running...
srun ./ascot5_main --in="./inputs/1M.h5" --out="./outputs/${SLURM_JOB_ID}.h5"
wait
RUNTIME=$(sacct -j $SLURM_JOB_ID --format=Elapsed -X | grep -E -o '([0-9]+:){2}([0-9]+)')
GPUS_PER_TASK=$(srun echo $SLURM_GPUS_PER_TASK)
echo $SLURM_JOB_ID,$SLURM_NNODES,$GPUS_PER_TASK,$RUNTIME,1M >> ./ascot_runs.csv
echo Recorded job info.