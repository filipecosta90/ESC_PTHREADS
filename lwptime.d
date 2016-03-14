dtrace:::BEGIN { 
  start = timestamp; 
  printf("MAIN THREAD START:\nSTART CSV:,%d\n", start);
}

proc:::lwp-create
{
}

proc:::lwp-start
{
  self->start = timestamp;
  self->difference_start = self->start - start;
}

proc:::lwp-exit
/tid != 1/

{
  self->end = timestamp;
  self->duration = self->end -  self->start;
  printf ( "THREAD EXIT:\nTHREAD CSV:,%d, %d,%d ,%d,%d\n", tid, self->start, self->end , self->duration, self->difference_start );
  self->start = 0;
}

dtrace:::END { 
  end = timestamp; 
  printf("MAIN THREAD END:\nEXIT CSV:,%d\n", end);
}


