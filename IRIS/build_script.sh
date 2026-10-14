#!/bin/bash
#SBATCH --job-name=build-ascot5
#SBATCH --partition=iris
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:10:00

module load intel/2023.2
module load compiler mkl
MPI=hpcx-2.25.1

module load $(echo $MPI | sed 's/x-/x\//')
export OMPI_CC=icc
module load hdf5/1.14.6-$MPI
module load python
make clean
make ascot5_main -j MPI=1 OMP=1 NSIMD=8 CC=mpicc
make libascot -j MPI=1 OMP=1 NSIMD=8 CC=mpicc