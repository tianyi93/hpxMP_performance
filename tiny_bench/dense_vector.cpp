#include<iostream>
#include<vector>
#include<omp.h>
#include <exception>
#define VECTOR_SIZE 100000
int main(){
	std::vector<float> a(VECTOR_SIZE,2.0f);
	std::vector<float> b(VECTOR_SIZE,3.0f);
	std::vector<float> c(2*VECTOR_SIZE,0);

	double start = omp_get_wtime();
#pragma omp parallel for
	for (int64_t i = 0; i < VECTOR_SIZE; i++){
		c[i] = a[i]+b[i];
	}
	double end = omp_get_wtime();
	float operations = VECTOR_SIZE*1/(end-start)/1000000;
	std::cout<<operations<<" mega float operations per seconds.\n";
	for (int64_t i = 0; i < VECTOR_SIZE; i++){
		if(c[i] != 5)
			throw std::invalid_argument("wrong result");
	}
	return 0;
}
