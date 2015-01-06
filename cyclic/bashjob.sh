#!/bin/bash
#MSUB -l nodes=1:ppn=6
#MSUB -l walltime=08:00:00
#MSUB -l pmem=4000mb
#MSUB -N re40_test 

echo "number of procs"> log
echo "$SLURM_NPROCS" >> log
cores=$SLURM_NPROCS
module load mpi/openmpi/1.6.5-gnu-4.7
module load cae/openfoam/2.2.2

source /opt/bwhpc/common/cae/openfoam/2.2.x/OpenFOAM-2.2.x/etc/bashrc

cd /work/workspace/scratch/st_lrt70667-test-0/cyclic/
mv job* oldjobslogs/
perl adjustToNodes.pl $SLURM_NPROCS
decomposeParHPC -force
mpirun -bind-to-core -bycore -report-bindings pisoFoam -parallel
reconstructParHPC 
