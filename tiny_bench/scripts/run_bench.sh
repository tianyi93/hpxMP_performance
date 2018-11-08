#!/bin/bash

echo "This script is used to a single hpxMP OpenMP tinybench 11 times,which runtime should I use, hpxmp or openmp"
read runtime
echo "which benchmark should I run?"
read bench_name
echo "where are you running this benchmark?"
read machine_name

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
			echo "${thread} threads, ${size} size, ${run}_th run"
			echo "$(OMP_NUM_THREADS=${thread} ../build/${bench_name} ${size})" "${thread}, ${size}">> ${runtime}_${bench_name}_${run}th_run
	    	done
    	done
done
