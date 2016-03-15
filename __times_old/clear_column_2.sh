#!bin/bash

for file in *.csv
do
  echo $file
  gawk -f clear_csv_2.gawk $file >> "clean_"$file
done
