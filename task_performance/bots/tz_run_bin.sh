#!/bin/sh
cd bin
#-c is check
num_threads=1
PS3='Please enter your choice: '
options=("openmp" "hpxmp" "both")
select opt in "${options[@]}"
do
	case $opt in
		"openmp")
		while [ $num_threads -le 40 ]
		do
			OMP_NUM_THREADS=$num_threads LD_PRELOAD=/home/tianyi/pkgs/repo/openmp/build/runtime/src/libomp.so ./fft.clang.omp-tasks-tied -c no
			((num_threads++))
		done
		;;
		"hpxmp")
		while [ $num_threads -le 40 ]
		do
			OMP_NUM_THREADS=$num_threads LD_PRELOAD=~/pkgs/repo/hpxMP_1003/cmake-build-release/libhpxmp.so ./fft.clang.omp-tasks-tied -c nh
			((num_threads++))
		done
		;;
		"both")
		while [ $num_threads -le 40 ]
		do
			OMP_NUM_THREADS=$num_threads LD_PRELOAD=/home/tianyi/pkgs/repo/openmp/build/runtime/src/libomp.so ./fft.clang.omp-tasks-tied -c no
			OMP_NUM_THREADS=$num_threads LD_PRELOAD=~/pkgs/repo/hpxMP_1003/cmake-build-release/libhpxmp.so ./fft.clang.omp-tasks-tied -c nh
			((num_threads++))
		done
		;;
	esac
done

