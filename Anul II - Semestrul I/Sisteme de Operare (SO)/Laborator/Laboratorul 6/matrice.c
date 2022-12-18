#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

int m[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
int mm[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
int r[3][3];

void *inmultire(void *v) 
{
	int * p = (int*) v;
	for (int j=0; j<3; j++)
		r[p[0]][p[1]] += m[p[0]][j] * mm[j][p[1]];
	return NULL;
}

int main (int argc, char **argv)
{
	pthread_t thr[3][3];
	int index[2];
	char *res;
	
	for (int i=0; i<3; i++)
		for (int j=0; j<3; j++)
			{
				int *index = (int*) malloc (sizeof(int)*2);
				index[0] = i;
				index[1] = j;
		
				if (pthread_create(&thr[i][j], NULL, inmultire, index))
					{
						perror(NULL);
						return errno;
					}
			}
	
	for (int i=0; i<3; i++) 
	{
		for (int j=0; j<3; j++) 
		{
			if (pthread_join(thr[i][j], (void **) &res))
			{
				perror(NULL);
				return errno;
			}
		}
	}
	
	for (int i=0; i<3; i++) 
	{
		for (int j=0; j<3; j++) 
		{
			printf ("%d ", r[i][j]);
		}
		printf ("\n");
	}
	
	return 0;
}
