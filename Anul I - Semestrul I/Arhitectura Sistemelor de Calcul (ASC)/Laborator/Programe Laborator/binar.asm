.data
	binar: .asciz "00001110"
	formatafisare: .asciz "%d\n"
	codificare: .long 0
	putere: .long 128
	doi: .long 2
.text

.global main

main:
	
	xorl %eax, %eax 
	xorl %ecx, %ecx
	movl $binar, %edi 
	
	movb (%edi, %ecx, 1), %al
	
	cmp $0, %al
	je exit
	
calculare:
	movb (%edi, %ecx, 1), %al
	
	movl putere, %ebx
	sub $48, %al
	xorl %edx, %edx
	mul %ebx
	
	add %eax, codificare
	
	movl doi, %ebx
	movl putere, %eax
	xorl %edx, %edx
	div %ebx
	movl %eax, putere
	incl %ecx
	
	cmp $8, %ecx
	je afisare
	jmp calculare

afisare: 
	pushl codificare
	pushl $formatafisare
	call printf
	popl %ebx
	popl %ebx
	 
	
exit: 
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	
