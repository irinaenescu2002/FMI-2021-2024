.data
	x: .space 4
	y: .space 4
	formatread: .asciz "%d %d"
	formatscan: .asciz "Suma celor doua numere este: %d\n"
.text

.global main

main:
	push $y
	push $x
	push $formatread
	call scanf
	pop %ebx
	pop %ebx
	pop %ebx

	mov x, %eax
	add y, %eax

	push %eax
	push $formatscan
	call printf
	pop %ebx
	pop %ebx

	push $0
	call fflush
	pop %ebx

exit: 
  mov $1, %eax
  mov $0, %ebx
  int $0x80
