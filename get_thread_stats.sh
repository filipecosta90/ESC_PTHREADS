#!bin/bash

mkdir __thread_dtrace

cd __csv
for file in DTRACE*.csv
do
  echo $file
  gawk -f ../thread_creation.gawk $file > ../"UNSORTED_"$file
  sort ../"UNSORTED_"$file > ../"THREAD_"$file
  rm ../"UNSORTED_"$file
done
cd ..

mv THREAD_* __thread_dtrace
