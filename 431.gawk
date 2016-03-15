BEGIN { FS=","; tid = 0; start =0; end=0; duration = 0; }
/0:1073741824/ {print $1","$2 }
END { }
