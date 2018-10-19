 #!/bin/bash
 clang++ -fopenmp -c arraybench.cpp
 clang++ -fopenmp -c common.cpp
 clang++ arraybench.o common.o -o arraybench -lomp
 
