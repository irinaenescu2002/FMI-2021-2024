#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main (int argc, char**argv) 
{
	int n, fisier_intrare, fisier_iesire;
	char buf[100];
	fisier_intrare = open(argv[1], O_RDONLY);
	n = read(fisier_intrare, buf, 20);
	fisier_iesire = open(argv[2], O_WRONLY|O_CREAT|O_TRUNC, S_IRWXU);
	while (n > 0)
	{
		write(fisier_iesire, buf, n);
		n = read(fisier_intrare, buf, 20);
	}
}
