#!/bin/bash
#SBATCH -J OpenCLmcfarlco
#SBATCH -A cs475-575
#SBATCH -p class
#SBATCH --gres=gpu:1
#SBATCH -o openclmulti.out
#SBATCH -e openclmulti.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mcfarlo@oregonstate.edu

for t in 1024 4096 16384 65536 262144 1048576 2097152 4194304 8388608 16777216
do
        for b in 8 32 64 128 256 512
        do
                g++ -DNUM_ELEMENTS=$t -DLOCAL_SIZE=$b -o multi ./openclmulti/multiadd.cpp /usr/local/apps/cuda/cuda-10.1/lib64/libOpenCL.so.1.1 -lm -fopenmp
                ./multi
        done
done