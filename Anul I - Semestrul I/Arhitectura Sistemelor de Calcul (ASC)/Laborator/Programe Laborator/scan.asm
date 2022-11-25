.data
	x: .space 4
	formatInt: .asciz "%d"

.text

.global main

main:

	push $x
	push $formatInt
	call scanf
	pop %ebx
	pop %ebx

et_exit:
  mov $1, %eax
  mov $0, %ebx
  int $0x80
