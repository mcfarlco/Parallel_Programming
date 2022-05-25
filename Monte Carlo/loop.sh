#!/bin/bash
g++ ./montecarlo/montecarlo.cpp -o montecarlo -lm -fopenmp
# number of threads:
for t in 1 2 4 6 8 10 12
    do
        # number of trials:
        for s in 65536 131072 262144 524288 1048576
            do
            ./montecarlo.exe $t $s
    done
done