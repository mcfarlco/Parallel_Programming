#!/bin/bash
g++ ./numericintegration/numericintegration.cpp -o numericintegration -lm -fopenmp
# number of threads:
for t in 1 2 3 4 5 6 7 8 9 10 11 12
    do
        # number of nodes:
        for s in 64 128 256 512 1024 2048 4096 8192 # 16384 32768 65536 131072 262144 524288 1048576 2097152 4194304 8388608
            do
            ./numericintegration.exe $t $s
        done
done
