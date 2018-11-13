#!/bin/bash

echo "This script is used to a single hpxMP OpenMP tinybench 11 times,hpxmp and openmp"
echo "which benchmark should I run?"
read bench_name
echo "where are you running this benchmark?"
read machine_name
echo "which compiler are you using ?"
read compiler

current_time="$(date +"%Y%m%d%H%M")"
mkdir ../result_${bench_name}_${machine_name}_${current_time}
cd ../result_${bench_name}_${machine_name}_${current_time}

vector_size=(10000 100000 100000 1000000 10000000 100000000 1000000000 10000000000)
thr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)
num_run=(1 2 3 4 5 6 7 8 9 10 11)

for run in  "${num_run[@]}"
do
	for size in "${vector_size[@]}"
    	do
	 	for thread in "${thr[@]}"
	    	do
			echo "openmp ${thread} threads, ${size} size, ${run}_th run"
			echo "$(LD_PRELOAD=/home/tzhang/pkgs_auto/openmp/build_${compiler}_${machine_name}_release/runtime/src/libomp.so OMP_NUM_THREADS=${thread} ../build/${bench_name} ${size})" "${thread}, ${size}">>openmp_${bench_name}_${run}th_run
			echo "hpxmp ${thread} threads, ${size} size, ${run}_th run"
			echo "$(LD_PRELOAD=/home/tzhang/pkgs_auto/hpxMP/build_${compiler}_${machine_name}_release/libhpxmp.so OMP_NUM_THREADS=${thread} ../build/${bench_name} ${size})" "${thread}, ${size}">>hpxmp_${bench_name}_${run}th_run
	    	done
    	done
done
