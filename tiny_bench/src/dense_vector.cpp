#include<iostream>
#include<vector>
#include<omp.h>
#include <exception>
#include <ctime>

int main(int argc, char* argv[]){
	int64_t vector_size = 0;
	if(argc > 1)
		vector_size = atoi(argv[1]);
	std::vector<float> a(vector_size,2.0f);
	std::vector<float> b(vector_size,3.0f);
	std::vector<float> c(vector_size,0);

	clock_t start = clock();
#pragma omp parallel for
	for (int64_t i = 0; i < vector_size; i++){
		c[i] = a[i]+b[i];
	}
	clock_t end = clock();
	double elapsed_secs = double(end-start)/CLOCKS_PER_SEC;
	float operations = vector_size*1/elapsed_secs/1000000;
	std::cout<<operations<<","<<std::endl;
	for (int64_t i = 0; i < vector_size; i++){
		if(c[i] != 5)
			throw std::invalid_argument("wrong result");
	}
	return 0;
}
