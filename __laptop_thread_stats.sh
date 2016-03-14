#!bin/bash

for method in mutex busy_wait semaphore
do
  for size in 1024 2048 4096 8192
  do
    echo $file
    gawk -F, "/0:$size/ {print}" $method >> $method"_"$size".csv"
  done
done
