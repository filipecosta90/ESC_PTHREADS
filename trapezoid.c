/**************************************************************
 *      ----- Simple POSIX Threads example kernel -----
 *      ----- Author: Filipe Costa Oliveira       -----
 *
 * Purpose: Calculate the defined integral using the trapezoidal rule and pthreads.
 * Input:   a, b, n
 * Output:  CSV file with the aproximate time spent calculating the integral from a to b of f(x) and n trapezoids.
 * Usage:   ./pth_trap <number of threads> <method> <a> <b> <n>
 * Methods: mutex / semaphore / busy_wait
 *
 **************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>
#include "timer.h"

/* global variables: accessible to all threads */
long   thread_count;
long  interval_a, interval_b;
double approx;
long   n_intervals;
double global_time_start, global_time_stop, total_time;
char method[10];

/* busy_wait global variables: */
int flag;

/* mutex global variables:*/
pthread_mutex_t   mutex;

/*  */
double f(double x) {
  double return_val;
  return_val = x*x; 
  return return_val; 
}

/* busy wait algorithm */
void* busy_wait_compute (  void* rank ) {
  long my_rank = (long) rank;
  double h = (interval_b - interval_a)/ n_intervals;
  long my_n = n_intervals / thread_count;
  long my_init_pos  = my_n * my_rank;
  long my_final_pos = my_init_pos + my_n;
  double x_i;

  for (long  i = my_init_pos ;i<=my_final_pos-1;i++) { 
    x_i = interval_a + i*h;
    while ( flag != my_rank );
    approx  +=  f(x_i); 
    flag = (flag+1) % thread_count;
  }

  return NULL;
} 

/* mutex algorithm */
void* mutex_compute (  void* rank ) {
  long my_rank = (long) rank;
  double h = (interval_b - interval_a)/ n_intervals;
  long my_n = n_intervals / thread_count;
  long my_init_pos  = my_n * my_rank;
  long my_final_pos = my_init_pos + my_n;
  double x_i;

  for (long  i = my_init_pos ;i<=my_final_pos-1;i++){ 
    x_i = interval_a + i*h;
    pthread_mutex_lock(&mutex);
    approx  +=  f(x_i); 
    pthread_mutex_unlock(&mutex);
  }

  return NULL;
} 

void print_results( int thread_count , char* method ){
  FILE * fp;
  total_time = global_time_stop - global_time_start;
  fp = fopen (method, "a");
  fprintf(fp, "%d,%f,%f,%f\n",thread_count, total_time, global_time_start , global_time_stop );
  fclose(fp);
}

int main(int argc, char* argv[]) {
  pthread_t*  thread_handles;
  /* the approximate value */
  approx = 0.0;
  /* the first thread to have access to the critical section in busy wait is thread #0*/
  flag = 0;
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

  /* allocate memory for thread handles */
  thread_handles = malloc (thread_count*sizeof(pthread_t));

  GET_TIME(global_time_start);
  if ( strcmp("mutex",method) == 0 ) {
    /* Initialize the mutex */
    pthread_mutex_init(&mutex, NULL);
    for (long thread_number = 0; thread_number < thread_count; thread_number++) {
      pthread_create(&thread_handles[thread_number], NULL, mutex_compute,(void*) thread_number);
    }
    pthread_mutex_destroy(&mutex);
  }
  if ( strcmp("semaphore",method) == 0 ) {

  }

  if ( strcmp("busy_wait",method) == 0 ) {
    for (long thread_number = 0; thread_number < thread_count; thread_number++) {
      pthread_create(&thread_handles[thread_number], NULL, busy_wait_compute,(void*) thread_number);
    }

  }
  /* Wait for threads to complete. */
  for (int i = 0; i < thread_count; i++) {
    pthread_join(thread_handles[i], NULL);
  }

  free(thread_handles);
  GET_TIME(global_time_stop);
  print_results( thread_count , method );
  return 0;
} /*  main  */
