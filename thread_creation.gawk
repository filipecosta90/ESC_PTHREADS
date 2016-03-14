BEGIN { FS=","; tid = 0; start =0; end=0; duration = 0; }
/THREAD CSV:/ { if ($3 == 0 ){tid = $2} else { print $2","$3","$4","$5","$6} }
/START CSV:/ { start = $2 }
/EXIT CSV:/ { end = $2; duration = end - start; print tid","start","end","duration","0 }
END { }
