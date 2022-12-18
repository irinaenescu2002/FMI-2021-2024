#include <pthread.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

#define MAX_RESOURCES 5
int available_resources = MAX_RESOURCES;

pthread_mutex_t mtx;

int decrease_count(int count)
{
	while (1) 
	{	
		pthread_mutex_lock (&mtx);
	
		if (available_resources < count)
			pthread_mutex_unlock (&mtx);			
		else
		{				
			available_resources -= count;
			printf("Got %d resources, remaining %d resources\n", count, available_resources);
			pthread_mutex_unlock (&mtx);
			return 0;
		}
	}
	
}

int increase_count(int count)
{
	pthread_mutex_lock (&mtx);	
	available_resources += count;
	printf("Release %d resources, remaining %d resources\n", count, available_resources);
	pthread_mutex_unlock (&mtx);
	return 0;
}

void *f(void *arg)
{
	int* count = (int*)arg;
	decrease_count(*count);
	increase_count(*count);
	return NULL;
}

int main()
{
	pthread_mutex_lock (&mtx);
	if (pthread_mutex_init (&mtx, NULL)) 
	{
		perror(NULL);
		return errno;
	}
	
	printf("MAX RESOURCES = %d\n", available_resources);
	
	pthread_t t[5];
	for (int i=0; i<5; i++)
	{
		int *count = (int *) malloc(sizeof(int));
		*count = rand()%(MAX_RESOURCES + 1);
		if (pthread_create(&t[i], NULL, f, count))
		{
			perror(NULL);
			return errno;
		}
	}
	
	for (int i=0; i<5; i++)
	{
		if (pthread_join(t[i], NULL))
		{
			perror(NULL);
			return errno;
		}
	}
	
	pthread_mutex_destroy(&mtx);
	
	return 0;	
}


