#!bin/bash

for method in mutex busy_wait semaphore
do
  for size in 1024 2048 4096 8192
  do
    gawk -F, "/0:$size/ {print}" $method >> $method"_"$size".csv"
  done
done

mv mutex __times
mv busy_wait __times
mv semaphore __times 
mv *.csv __times
