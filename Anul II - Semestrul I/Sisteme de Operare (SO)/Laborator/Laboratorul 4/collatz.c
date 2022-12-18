#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

int main (int argc, char **argv)
{
	int n = atoi(argv[1]);
	pid_t pid = fork ();
	if (pid < 0)
		return errno;
	else if (pid == 0){
		while (n != 1) {
			printf("%d ", n);
			if (n % 2 == 0)
				n = n/2;
			else n = 3*n + 1;
		}
		printf("1\n");
	}
	else {
		int w = wait(NULL);
		printf("Child PID: %d finished\n", w);
		printf("Parent PID: %d\n", getpid());
	}
	return 0;
}
