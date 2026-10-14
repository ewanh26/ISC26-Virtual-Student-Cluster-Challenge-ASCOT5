#!/bin/bash
#SBATCH --job-name=build-ascot5
#SBATCH --nodes=1
#SBATCH --partition=instant
#SBATCH --account=r250119
#SBATCH --time=00:10:00
#SBATCH --mem=16G
#SBATCH --constraint=armgpu

module use /gpfs/projet/r250119/tools/nvhpc/modulefiles
module load nvhpc-hpcx-cuda12/26.1
module load hdf5-1.14.6
make ascot5_main -j MPI=1 ACC=1 GPU=1 CC=mpicc
make libascot -j MPI=1 ACC=1 GPU=1 CC=mpicc