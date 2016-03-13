
CC = icc

#flags

CFLAGS= -Wall -O2 -O3 -lpthread

trapezoid: trapezoid.o 
	$(CC) $(CFLAGS) -o pth_trap trapezoid.c

all: trapezoid 

.PHONY: clean
clean:
	rm  *.o && rm pth_trap*
