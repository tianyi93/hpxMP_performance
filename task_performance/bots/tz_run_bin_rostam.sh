#!/bin/sh
cd bin
#-c is check
PS3='Please enter your choice: '
options=("openmp" "hpxmp" "both")
select opt in "${options[@]}"
do
	for num_run in 1 2 3
	do
		num_threads=1
		case $opt in
			"openmp")
			while [ $num_threads -le 40 ]
			do
				OMP_NUM_THREADS=$num_threads LD_PRELOAD=/home/tzhang/openmp/build_release/runtime/src/libomp.so ./fft.clang.omp-tasks-tied no $num_run
				((num_threads++))
			done
			;;
			"hpxmp")
			while [ $num_threads -le 40 ]
			do
				OMP_NUM_THREADS=$num_threads LD_PRELOAD=/home/tzhang/hpxMP/build_release/libhpxmp.so ./fft.clang.omp-tasks-tied -c nh $num_run
				((num_threads++))
			done
			;;
			"both")
			while [ $num_threads -le 40 ]
			do
				OMP_NUM_THREADS=$num_threads LD_PRELOAD=/home/tzhang/openmp/build_release/runtime/src/libomp.so ./fft.clang.omp-tasks-tied -c no $num_run
				OMP_NUM_THREADS=$num_threads LD_PRELOAD=/home/tzhang/hpxMP/build_release/libhpxmp.so ./fft.clang.omp-tasks-tied -c nh $num_run
				((num_threads++))
			done
			;;
		esac
	done
done

