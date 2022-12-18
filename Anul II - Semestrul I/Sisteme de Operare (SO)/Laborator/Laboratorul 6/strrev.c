#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

void *reverse (void *s)
{
	char *w = (char*) s;
	char *inv = (char*) malloc (strlen(w) * sizeof(char));
	int l = strlen (w);
	for (int i = l - 1; i>=0; i--)
		inv[l - 1 - i] = w[i];
	return inv;
}

int main (int argc, char **argv)
{
	pthread_t thr;
	if (pthread_create(&thr, NULL, reverse, argv[1]))
	{
		perror(NULL);
		return errno;
	}
	char *res;
	if (pthread_join(thr, (void **) &res))
	{
		perror(NULL);
		return errno;
	}
	printf("%s\n", res);
	return 0;
}
