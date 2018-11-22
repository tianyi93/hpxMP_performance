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

#vector_size=(100000 200000 300000 400000 500000 600000 700000 800000 900000 1000000)
thr=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)
num_run=(1 2 3 4 5 6 7 8 9 10 11)

for run in  "${num_run[@]}"
do
	echo "num_threads,vector_size,mfc/s">>openmp_${bench_name}_${run}th_run.csv
	echo "num_threads,vector_size,mfc/s,hpx_counter">>hpxmp_${bench_name}_${run}th_run.csv
	for ((size_k=1000;size_k<=10000;size_k+=1000));
    	do
		size=$((${size_k}*1000))
	 	for thread in "${thr[@]}"
	    	do
			echo "openmp ${thread} threads, ${size} size, ${run}_th run"
			echo "${thread}, ${size}" "$(OMP_NUM_THREADS=${thread} ../build/${bench_name} ${size})" "\"">>openmp_${bench_name}_${run}th_run.csv
			echo "hpxmp ${thread} threads, ${size} size, ${run}_th run"
			echo "${thread}, ${size}" "$(OMP_HPX_ARGS=--hpx:print-counter=/threads{locality#*/total}/idle-rate LD_PRELOAD=/home/tzhang/pkgs_auto/hpxMP/build_${compiler}_${machine_name}_release/libhpxmp.so OMP_NUM_THREADS=${thread} ../build/${bench_name} ${size})" "\"">>hpxmp_${bench_name}_${run}th_run.csv
	    	done
    	done
done
