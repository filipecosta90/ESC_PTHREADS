#!bin/bash

mkdir __thread_dtrace_create

for file in DTRACE*.csv
do
  echo $file
  gawk -f thread_creation.gawk $file > "UNSORTED_"$file
  sort "UNSORTED_"$file > "THREAD_"$file
  rm "UNSORTED_"$file
done

mv THREAD_* __thread_dtrace_create
