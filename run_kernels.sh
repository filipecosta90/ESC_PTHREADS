#!bin/bash

for method in semaphore mutex busy_wait
do
  for nthreads in 1 2 4 8 16 32 64 128
  do
    for size in 1024 2048 4096 8192
    do
      var int_a = 0;
      var int_b = $size;
      var int_n = $nthreads;
      dtrace -s lwptime.d -c "./pth_trap $nthreads $method $int_a $int_b $int_n" >> "DTRACE_"$method"_"$nthreads"_"$int_a"_"$int_b"_"$int_n".csv"
    done
  done
done

