.data
	n: .long 5
	suma: .space 4
.text
.globl _start

_start:
	mov $0, %ecx

loop:
	cmp n, %ecx
	je exit
	add %ecx, suma
	add $1, %ecx
	jmp loop

exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
