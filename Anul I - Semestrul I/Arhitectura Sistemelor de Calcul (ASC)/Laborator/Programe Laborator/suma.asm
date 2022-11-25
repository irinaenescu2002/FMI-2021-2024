.data
	x: .long 5
	y: .long 2
	sum: .space 4
.text
.globl _start

_start:
	mov x, %eax
	mov y, %ebx
	add %ebx, %eax
	mov %eax, sum

etexit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
