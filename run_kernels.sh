#!bin/bash

for method in semaphore mutex busy_wait
do
  for nthreads in 1 2 4 8 16 32 64 128
  do
    for size in 1024 2048 4096 8192
    do
      echo   "./pth_trap $nthreads $method 0 $size $nthreads" 
      dtrace -s lwptime.d -c "./pth_trap $nthreads $method 0 $size $nthreads" >> "DTRACE_"$method"_"$nthreads"_"0"_"$size"_"$nthreads".csv"
    done
  done
done

mkdir __csv
mv DTRACE*.csv __csv
