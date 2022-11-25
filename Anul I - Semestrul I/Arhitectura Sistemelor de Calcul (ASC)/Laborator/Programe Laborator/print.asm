.data
	formatPrint: .asciz "%s"
	text: .asciz "program asm"
	
.text

.global main

main:

	push text
	push $formatPrint
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
