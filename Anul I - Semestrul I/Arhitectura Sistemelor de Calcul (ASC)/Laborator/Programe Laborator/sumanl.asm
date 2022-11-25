.data
	x: .long 5
	suma: .space 4
.text
.globl _start

_start:
	mov x, %ecx
	dec %ecx

etloop:
	add %ecx, suma
	loop etloop
	jmp exit

exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
