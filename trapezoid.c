/**************************************************************
 *      ----- Simple POSIX Threads example kernel -----
 *      ----- Author: Filipe Costa Oliveira       -----
 *
 * Purpose: Calculate the defined integral using the trapezoidal rule and pthreads.
 * Input: a, b, n
 * Output:   Estimate of the integral from a to b of f(x) and n trapezoids.
 * Usage:     ./pth_trap <number of threads> <method> <a> <b> <n>
 * Methods:
 * 1 : mutex / 2: semaphore / 3: busy_wait
 *
 **************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include "timer.h"

/* global variables: accessible to all threads */
int     thread_count;
double  interval_a, interval_b, interval_h;
int     n_intervals;
double global_time_start, global_time_stop, total_time;
char method[10];

double f(double x) {
  double return_val;
  return_val = x*x; 
  return return_val; 
}

void print_results( int thread_count , char* method ){
   FILE * fp;
  total_time = global_time_stop - global_time_start;
  fp = fopen (method, "w+");
  fprintf(fp, "%d,%f,%f,%f\n",thread_count, total_time, global_time_start , global_time_stop );
  fclose(fp);
}

int main(int argc, char* argv[]) {
  long        thread;

  pthread_t*  thread_handles;  

  if (argc != 6) {
    fprintf(stderr, "invalid arg count\nusage: ./pth_trap <number of threads> <method> <a> <b> <n>\n");
    exit(0);
  }

  /* get the number of threads from command line */
  thread_count = strtol(argv[1], NULL, 10);
  strcpy( method , argv[2] );
  interval_a = strtol(argv[3], NULL, 10);
  interval_b = strtol(argv[4], NULL, 10);
  n_intervals = strtol(argv[5], NULL, 10);
  interval_h = ( interval_b - interval_a) / n_intervals;

  /* allocate memory for thread handles */
  thread_handles = malloc (thread_count*sizeof(pthread_t));

  GET_TIME(global_time_start);
  if ( strcmp("mutex",method) == 0 ) {

    printf("mutex");

  }
  if ( strcmp("semaphore",method) == 0 ) {

    printf("semaphore");
  }

  if ( strcmp("busy_wait",method) == 0 ) {

    printf("busy_wait");
  }
  free(thread_handles);
  GET_TIME(global_time_stop);
  print_results( thread_count , method );
  return 0;
} /*  main  */
