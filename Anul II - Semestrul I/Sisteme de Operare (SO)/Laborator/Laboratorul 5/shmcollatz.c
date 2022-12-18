#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/errno.h>
#include <sys/mman.h>

int main(int argc, char *argv[])
{
    printf ("Starting Parent: %d\n", getpid());

    char *shm_name = "my_shm";
    int shm_fd = shm_open(shm_name, O_RDWR|O_CREAT, 600);

    if (shm_fd < 0)
    {
        perror(NULL);
        return errno;
    }

    size_t page_size=getpagesize();
    size_t shm_size=page_size*argc;
    
    if(ftruncate(shm_fd, shm_size) == -1)
    {
        perror(NULL);
        shm_unlink(shm_name);
        return errno;
    }

    char *shm_ptr;
    for (int i=1; i<argc; i++)
    {

        shm_ptr = mmap(0, page_size, PROT_WRITE, MAP_SHARED, shm_fd, (i-1)*page_size);

        if (shm_ptr == MAP_FAILED)
        {
            perror("NULL");
            shm_unlink(shm_name);
            return errno;
        }

        pid_t pid=fork();
        
        if (pid < 0)
        {
            perror(NULL);
            return errno;
        }
        else if (pid == 0)
        {
            int n = atoi(argv[i]);
            shm_ptr += sprintf(shm_ptr, "%d: ", n);
            
            while (n!=1)
            {   
                shm_ptr += sprintf(shm_ptr, "%d ", n);
                if (n%2 == 0)
                    n /= 2;
                else n = 3*n + 1;
            }
            
            printf("Done Parent %d Me %d\n",  getppid(), getpid());
            shm_ptr += sprintf(shm_ptr, "1");
	    exit(0);
        }

        munmap(shm_ptr, page_size);
    }

    for(int i=1; i<argc; i++)
        wait(NULL);

    for(int i=1; i<argc; i++)
    {
        shm_ptr=mmap(0, page_size, PROT_READ, MAP_SHARED, shm_fd, (i-1)*page_size);
        printf("%s\n", shm_ptr);
        munmap(shm_ptr, page_size);
    }

    shm_unlink(shm_name);
    printf("Done Parent %d Me %d\n", getppid(), getpid());

    return 0;
}
