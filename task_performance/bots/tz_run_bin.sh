#!/bin/sh
cd bin
#-c is check
OMP_NUM_THREADS=5 LD_PRELOAD=~/pkgs/repo/hpxMP_1003/cmake-build-release/libhpxmp.so ./fft.clang.omp-tasks-tied -c

