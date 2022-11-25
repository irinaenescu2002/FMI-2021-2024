.data
	xcaracter: .asciz "sub"
	xintreg: .space 4
	
.text

.global main

main:
	push $xcaracter
	call atoi
	pop %ebx
	movl %eax, xintreg
	
exit:
	mov $1, %eax
	mov $0, %eax
	int $0x80
