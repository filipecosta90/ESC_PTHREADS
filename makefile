
CC = /usr/gcc/4.8/bin/g++ 
#flags

CFLAGS=--std=c++11 -Wall -O2 -fopenmp 

ex2: 
	$(CC) $(CFLAGS) -o ex2_v2 ex2_v2.cpp

all: ex2 

.PHONY: clean
clean:
	rm  *.o && rm ex2_v2
