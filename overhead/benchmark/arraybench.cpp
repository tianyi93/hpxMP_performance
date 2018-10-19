/****************************************************************************
*                                                                           *
*             OpenMP MicroBenchmark Suite - Version 3.0                     *
*                                                                           *
*                            produced by                                    *
*                                                                           *
*             Mark Bull, Fiona Reid and Nix Mc Donnell                      *
*                                                                           *
*                                at                                         *
*                                                                           *
*                Edinburgh Parallel Computing Centre                        *
*                                                                           *
*         email: markb@epcc.ed.ac.uk or fiona@epcc.ed.ac.uk                 *
*                                                                           *
*                                                                           *
*      This version copyright (c) The University of Edinburgh, 2011.        *
*                                                                           *
*                                                                           *
*  Licensed under the Apache License, Version 2.0 (the "License");          *
*  you may not use this file except in compliance with the License.         *
*  You may obtain a copy of the License at                                  *
*                                                                           *
*      http://www.apache.org/licenses/LICENSE-2.0                           *
*                                                                           *
*  Unless required by applicable law or agreed to in writing, software      *
*  distributed under the License is distributed on an "AS IS" BASIS,        *
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
*  See the License for the specific language governing permissions and      *
*  limitations under the License.                                           *
*                                                                           *
****************************************************************************/

#include <iostream>
#include <stdlib.h>
#include <math.h>
#include <omp.h>
#include <fstream>

#include "common.h"
#include "arraybench.h"

#define IDA 100

double btest[IDA];
double atest[IDA];

#pragma omp threadprivate (btest)

int main(int argc, char **argv) {

    init(argc, argv);

    /* GENERATE REFERENCE TIME */
    reference("reference time 1", &refer);

    char testName[32];

    /* TEST  PRIVATE */
    sprintf(testName, "FIRSTPRIVATE %d", IDA);

    std::ofstream myfile;
    myfile.open ("hpxMP_firstpriv_ben.txt");

    for(int i = 1; i<=46; i++){
        omp_set_num_threads(i);
        benchmark(testName, &testprivnew);
        myfile<< i <<","<<elapsed_time<<"\n";
    }


//    /* TEST  FIRSTPRIVATE */
//    sprintf(testName, "PRIVATE %d", IDA);
//    benchmark(testName, &testfirstprivnew);
//
//#ifdef OMPVER2
//    /* TEST  COPYPRIVATE */
//    sprintf(testName, "COPYPRIVATE %d", IDA);
//    benchmark(testName, &testcopyprivnew);
//#endif
//
//    /* TEST  THREADPRIVATE - COPYIN */
//    sprintf(testName, "COPYIN %d", IDA);
//    benchmark(testName, &testthrprivnew);
//
//    finalise();
//
//    return EXIT_SUCCESS;

}

void refer() {
    int j;
    double a[1];
    for (j = 0; j < innerreps; j++) {
	array_delay(delaylength, a);
    }
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

void testprivnew() {
    int j;
    for (j = 0; j < innerreps; j++) {
#pragma omp parallel private(atest)
	{
	    array_delay(delaylength, atest);
	}
    }
}

#ifdef OMPVER2
void testcopyprivnew()
{
    int j;
    for (j=0; j<innerreps; j++) {
#pragma omp single copyprivate(btest)
	{
	    array_delay(delaylength, btest);
	}
    }
}

#endif

void testthrprivnew() {
    int j;
    for (j = 0; j < innerreps; j++) {
#pragma omp parallel copyin(btest)
	{
	    array_delay(delaylength, btest);
	}
    }

}
