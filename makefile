
CC = gcc-5

#flags

CFLAGS= -Wall -lpthread

trapezoid: trapezoid.o 
	$(CC) $(CFLAGS) -o pth_trap trapezoid.c

all: trapezoid 

.PHONY: clean
clean:
	rm  *.o && rm pth_trap*
