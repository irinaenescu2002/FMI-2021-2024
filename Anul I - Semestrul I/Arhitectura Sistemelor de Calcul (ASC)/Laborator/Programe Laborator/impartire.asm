.data
	x: .long 21
	y: .long 5
	cat: .space 4
	rest: .space 4
.text
.globl _start
_start:
	mov x, %eax
	mov y, %ebx
	div %ebx
	mov %eax, cat
	mov %edx, rest
etexit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
