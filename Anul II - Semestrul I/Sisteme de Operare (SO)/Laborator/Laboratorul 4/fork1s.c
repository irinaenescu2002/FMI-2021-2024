#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int main ()
{
	pid_t pid = fork ();
	if (pid < 0)
		return errno;
	else if (pid == 0){
		char *argv[] = {"ls", NULL};
		execve ("/bin/ls", argv , NULL);
		perror(NULL);
		}
	else {
		printf("Child PID: %d\n", pid);
		wait(NULL);
		printf("Parent PID: %d\n", getpid());
	}
	return 0;
}
