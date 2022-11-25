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
	valori: .space 40
	
	minusunu: .long -1
	salvareavietii: .long 4
.text

.global main

main:

	xorl %ecx, %ecx
	movl $valori, %esi
initializare:
	cmp $27, %ecx
	je citire
	movl minusunu, %edx
	movl %edx, (%esi, %ecx, 4)
	xorl %edx, %edx
	incl %ecx
	jmp initializare

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
	
	cmp $0, %eax
	je variabilasauoperatie
	
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
	je variabilasauoperatie
	
continuareparcurgere:
	push atoires
	jmp parcurgere
	
variabilasauoperatie: 
	movl res, %edi 
	xorl %ecx, %ecx
	
	push res
	call strlen
	pop %ebx
	
	cmp $1, %eax
	je urcavariabila
	
	cmp $3, %eax
	je operatii	
	
urcavariabila: 
	xorl %ecx, %ecx
	mov (%edi, %ecx, 1), %al
	
	movl %eax, salvareavietii	
	sub $97, %eax		
	movl %eax, %ecx	
	
	movl (%esi, %ecx, 4), %edx
	
	cmp minusunu, %edx
	je urcamcod
	
	cmp minusunu, %edx
	jne urcavaloare

urcamcod:
	push salvareavietii
	jmp parcurgere

urcavaloare:
	mov (%esi, %ecx, 4), %al
	push %eax
	jmp parcurgere
	
operatii: 
	xorl %ecx, %ecx
	movb (%edi, %ecx, 4), %al
	
	cmp $97, %al
	je add
	
	cmp $115, %al
	je sub
	
	cmp $109, %al
	je mul
	
	cmp $100, %al
	je div
	
	cmp $108, %al
	je let
	
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

let: 
	pop %ebx		
	pop %eax	
	
	sub $97, %eax		
	movl %eax, %ecx	
	movl %ebx, (%esi, %ecx, 4)
	
	xorl %edx, %edx
	xorl %eax, %eax
	xorl %ecx, %ecx
	
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
