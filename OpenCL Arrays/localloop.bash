#!/bin/bash

for t in 1024 4096 16384
do
        for b in 8 32 64 128
        do
                g++ -DNUM_ELEMENTS=$t -DLOCAL_SIZE=$b -o multi ./openclmulti/multiadd.cpp -L "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.7\lib\x64" -lOpenCL -fopenmp
                ./multi
        done
done