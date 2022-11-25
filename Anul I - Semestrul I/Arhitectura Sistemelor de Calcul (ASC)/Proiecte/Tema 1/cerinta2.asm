.data
	sir: .space 400
	spatiu: .asciz " "
	res: .space 4
	formatafisare: .asciz "%d\n"
	primulnumar: .space 4
	atoires: .space 4
	eval: .space 4
	rasadd: .space 4
	rasmul: .space 4
	rassub: .space 4
	rasdiv: .space 4
	
.text

.global main

main:

citire:
	push $sir
	call gets
	pop %ebx

strtokprimulnumar:
	push $spatiu
	push $sir
	call strtok
	pop %ebx
	pop %ebx
	
	movl %eax, res
	
atoiprimulnumar:
	push res
	call atoi
	pop %ebx
	
	movl %eax, primulnumar
	push primulnumar
	
parcurgere:
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	cmp $0, %eax
	je afisare
	
	mov %eax, res
	
	push res
	call atoi
	pop %ebx
	
	mov %eax, atoires
	
	cmp $0, atoires
	je operatii
	
continuareparcurgere:
	push atoires
	jmp parcurgere
	
operatii: 
	movl res, %edi 
	xorl %ecx, %ecx

	movb (%edi, %ecx, 1), %al
	
	cmp $97, %al
	je add
	
	cmp $115, %al
	je sub
	
	cmp $109, %al
	je mul
	
	cmp $100, %al
	je div
	
add:
	xorl %ebx, %ebx
	pop %ebx
	pop %eax
	add %eax, %ebx
	mov %ebx, rasadd
	xorl %ebx, %ebx
	xorl %eax, %eax
	push rasadd
	jmp parcurgere

sub:
	xorl %ebx, %ebx
	pop %eax
	pop %ebx
	sub %eax, %ebx
	mov %ebx, rassub
	xorl %ebx, %ebx
	xorl %eax, %eax
	push rassub	
	jmp parcurgere

mul:
	popl %eax
	popl %ebx
	imul %ebx
	mov %eax, rasmul
	xorl %ebx, %ebx
	xorl %eax, %eax
	push rasmul
	jmp parcurgere
	
div:
	xorl %edx, %edx
	pop %ebx
	pop %eax
	idiv %ebx
	mov %eax, rasdiv
	xorl %eax, %eax
	xorl %ebx, %ebx
	xorl %edx, %edx
	push rasdiv
	jmp parcurgere

afisare:
	popl eval
	pushl eval
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
exit: 
	mov $1, %eax
	mov $0, %ebx
	int $0x80
