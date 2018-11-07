#!/bin/sh
#create binary file in ./bin
#look into ./config to configure compiler you wanna use when you do make
./configure
mkdir bin
make -j

