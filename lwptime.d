dtrace:::BEGIN { 
start = timestamp; 
printf("Hello ESC ! %d\n", start);

}

proc:::lwp-create
{
/* printf("%s, %d \t,started at: %d, %d after first \n", stringof(args[1]->pr_fname), args[0]->pr_lwpid, timestamp, timestamp-start );
*/
   }

proc:::lwp-start
{
  self->start = timestamp;
  self->difference_start = self->start - start;
}

proc:::lwp-exit
{
  self->end = timestamp;
  self->duration = self->end -  self->start;
  printf ( "tid %d, started %d, ended %d , duration %d,  difference from start %d\n", tid, self->start, self->end , self->duration, self->difference_start );
/* @[tid, stringof(curpsinfo->pr_fname)] =sum(timestamp - self->start);
  @[tid, stringof(curpsinfo->pr_fname)] =sum(self->difference_start);
 */ self->start = 0;
}
