
CC = gcc

#flags

CFLAGS= -Wall -fopenmp -lpthread

create: create.o 
	$(CC) $(CFLAGS) -o pth_create create.c

trapezoid: trapezoid.o 
	$(CC) $(CFLAGS) -o pth_trap trapezoid.c

all: trapezoid create

.PHONY: clean
clean:
	rm  *.o && rm pth_* 
