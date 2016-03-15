#!bin/bash

  for nthreads in 0 1 2 4 8 16 32 64 128 256
    do
      dtrace -s lwptime.d -c "./pth_create $nthreads " >> "DTRACE_CREATE_"$nthreads".csv"
    done

