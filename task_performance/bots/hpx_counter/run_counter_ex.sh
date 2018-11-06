#!/bin/sh
LD_PRELOAD=~/pkgs/repo/hpxMP_1003/build_release_clang/libhpxmp.so OMP_HPX_ARGS=--hpx:print-counter=/threads{locality#0/worker-thread#*}/idle-rate ../bin/fft.clang.omp-tasks-tied >>../hpx_counter/fft.clang.omp-task-tied-idle-rate.txt


