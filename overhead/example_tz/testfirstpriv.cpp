#include <iostream>
#include <string.h>
#include <omp.h>
#include <fstream>

double atest[1000];
int innerreps = 40;
int delaylength = 100000;
int MAX_THREADS = 46;
int outerreps = 20;

void array_delay(int delaylength, double a[2]) {
    int i;
    a[0] = 1.0;
    for (i = 0; i < delaylength; i++)
        a[0] += i;
    if (a[0] < 0)
        printf("%f \n", a[0]);

}

void testfirstprivnew() {
    int j;
    for (j = 0; j < innerreps; j++) {
#pragma omp parallel firstprivate(atest)
        {
            array_delay(delaylength, atest);
        }
    }
}

int main(){
    std::ofstream myfile;
    myfile.open ("openMP_firstpriv.txt");

    for(int i=1; i<=MAX_THREADS; i++){
        double sum = 0.0;
        omp_set_num_threads(i);
        for(int j = 0; j <outerreps; j++){
            double start = omp_get_wtime();
            testfirstprivnew();
            double stop = omp_get_wtime();
            double elapsed_time = stop - start;
            sum += elapsed_time;
            std::cout << "number of threads: "<<i<<","<<j<<"th run, elapsed time: " << elapsed_time << "seconds\n";
        }
        myfile<< i <<","<<sum/outerreps*1000<<"\n";
    }

    return 0;
}