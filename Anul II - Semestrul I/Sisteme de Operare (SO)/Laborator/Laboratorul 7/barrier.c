#include <pthread.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <semaphore.h>

#define NTHRS 5

pthread_mutex_t mtx;
sem_t sem;
int global_s = 0;

int barrier_pt()
{
	int local_s;
	pthread_mutex_lock (&mtx);	
	global_s ++;
	local_s = global_s;
	pthread_mutex_unlock (&mtx);
	
	if (local_s < NTHRS)
		if (sem_wait(&sem)) 
		{
			perror(NULL);
			return errno;
		}
		else ;
	else 
		for (int i=0; i<NTHRS; i++)
			sem_post(&sem);
}

void * tfun(void *v)
{
	int *tid = (int *)v;
	printf ("%d reached the barrier\n", *tid);
	barrier_pt ();
	printf ("%d passed the barrier\n", *tid);
	free(tid);
	return NULL;
}

int main()
{
	pthread_t t[10];
	
	if (sem_init(&sem, 0, global_s)) 
	{
		perror(NULL);
		return errno;
	}
	
	if (pthread_mutex_init(&mtx, NULL))
	{
		perror(NULL);
		return errno;
	}
	
	for(int i=0; i<NTHRS; i++)
	{
		int *a = (int*) malloc(1);
		*a = i;
		if (pthread_create(&t[i], NULL, tfun, a))
		{
			perror(NULL);
			return errno;
		}
	}
	
	for(int i=0; i<NTHRS; i++)
		if (pthread_join(t[i], NULL))
		{
			perror(NULL);
			return errno;
		}
		
	sem_destroy(&sem);
	pthread_mutex_destroy(&mtx);
	
	return 0;
}
