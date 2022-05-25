#!/bin/bash
#SBATCH -J CUDAmcfarlco
#SBATCH -A cs475-575
#SBATCH -p class
#SBATCH --gres=gpu:1
#SBATCH -o cudamontecarlo.out
#SBATCH -e cudamontecarlo.err
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=mcfarlo@oregonstate.edu

for t in 1024 4096 16384 65536 262144 1048576 2097152 4194304 8388608 16777216
do
        for b in 8 32 64 128
        do
                /usr/local/apps/cuda/cuda-10.1/bin/nvcc -DNUMTRIALS=$t -DBLOCKSIZE=$b -o cudamontecarlo  ./cuda_montecarlo/cudamontecarlo.cu
                ./cudamontecarlo
        done
done