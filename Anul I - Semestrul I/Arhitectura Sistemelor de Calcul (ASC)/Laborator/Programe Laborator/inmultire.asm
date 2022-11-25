.data
	x: .long 21
	y: .long 3
	inm: .space 4
.text
.globl _start

_start:
	mov x, %eax
	mov y, %ebx
	mul %ebx
	mov %eax, inm

etexit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
