.data
	x: .long 17
	y: .long 4
	dif: .space 6
.text
.globl _start

_start:
	mov x, %eax
	mov y, %ebx
	sub %ebx, %eax
	mov %eax, dif

etexit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
