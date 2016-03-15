/**************************************************************
 *      ----- Simple POSIX Threads example kernel -----
 *      ----- Author: Filipe Costa Oliveira       -----
 *
 * Purpose: Calculate the necessary time to create and delete an POSIX Thread.
 * Input:   n_threads
 * Output:  CSV file with the aproximate time spent creating and deleting the thread.
 * Usage:   ./pth_create <number of threads> 
 *
 **************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <string.h>
#include "timer.h"

/* global variables: accessible to all threads */
long   thread_count;
double global_time_start, global_time_stop, total_time;

void print_results( int thread_count ){
	FILE * fp;
	total_time = global_time_stop - global_time_start;
	fp = fopen ("create_delete", "a");
	fprintf(fp, "%d,%f\n",thread_count, total_time);
	fclose(fp);
}

int main(int argc, char* argv[]) {
	pthread_t*  thread_handles;

	if (argc != 2) {
		fprintf(stderr, "invalid arg count\nusage: ./pth_create <number of threads>\n");
		exit(0);
	}

	/* get the number of threads from command line */
	thread_count = strtol(argv[1], NULL, 10);

	/* allocate memory for thread handles */
	thread_handles = malloc (thread_count*sizeof(pthread_t));

	GET_TIME(global_time_start);
	long thread_number = 0;
	for (thread_number = 0; thread_number < thread_count; thread_number++) {
		pthread_create(&thread_handles[thread_number], NULL, NULL,NULL);
	}
	/* Wait for threads to complete. */
	int i = 0;    
	for (i = 0; i < thread_count; i++) {
		pthread_join(thread_handles[i], NULL);
	}
	GET_TIME(global_time_stop);
	free(thread_handles);
	print_results( thread_count );
	return 0;
} /*  main  */
