.data
	x: .space 4
	count: .long 0
	salveax: .space 4
	format: .asciz "%d"
	formatPrint: .asciz "%d"
.text

.global main

f: 
	pushl %ebp
	mov %esp, %ebp
	movl 4(%ebp), %eax
	cmp $1, %eax
	je neoprim
	
	movl %eax, salveax
	
	xorl %edx, %edx
	movl $2, %ebx
	div %ebx
	
	cmp $0, %edx
	je par
	
	cmp $1, %edx
	je impar
	
par: 
	movl salveax, %eax
	xorl %edx, %edx
	div %ebx
	
	incl count 
	pushl %eax
	call f
	popl %ebx
	
impar: 
	movl salveax, %eax
	xorl %edx, %edx
	movl $3, %ebx
	mul %ebx
	addl $1, %eax
	
	incl count 
	pushl %eax
	call f
	popl %ebx
	
neoprim:
	incl count
	movl count, %eax
	popl %ebx
	ret 

main:
	push $x
	push $format
	call scanf
	pop %ebx
	pop %ebx
	
	pushl x
	call f
	popl %ebx
	
	push %eax
	push $formatPrint
	call printf
	pop %ebx
	pop %ebx

	push $0
	call fflush
	pop %ebx

exit: 
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
