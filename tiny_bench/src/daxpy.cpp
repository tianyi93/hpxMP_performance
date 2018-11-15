#include<iostream>
#include<vector>
#include<omp.h>
#include <exception>

int main(int argc, char* argv[]){
	int64_t vector_size = 0;
	if(argc > 1)
		vector_size = atoi(argv[1]);
	std::vector<float> a(vector_size,2.0f);
	std::vector<float> b(vector_size,3.0f);
	std::vector<float> c(2*vector_size,0);

	double start = omp_get_wtime();
#pragma omp parallel for
	for (int64_t i = 0; i < vector_size; i++){
		c[i] = 6.0*a[i]+b[i];
	}
	double end = omp_get_wtime();
	float operations = vector_size*3/(end-start)/1000000;
	std::cout<<operations<<","<<std::endl;
	for (int64_t i = 0; i < vector_size; i++){
		if(c[i] != 15)
			throw std::invalid_argument("wrong result");
	}
	return 0;
}
