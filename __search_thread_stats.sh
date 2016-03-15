#!bin/bash

for method in omp 
do
  for size in 1073741824
  do
    gawk -f '431.gawk' $method >> $method"_"$size".csv"
  done
done

#mkdir __times
#mv mutex __times
#mv busy_wait __times
#mv semaphore __times 
#mv *.csv __times
