#!bin/bash

mkdir __thread_dtrace

cd __csv
for file in DTRACE*.csv
do
  echo $file
  gawk -f ../thread_creation.gawk $file > ../"THREAD_"$file
done
cd ..

mv THREAD_* __thread_dtrace

echo "sorting"
for file in __thread_dtrace/*
do 
  sort $file > "sorted_"$file
done
