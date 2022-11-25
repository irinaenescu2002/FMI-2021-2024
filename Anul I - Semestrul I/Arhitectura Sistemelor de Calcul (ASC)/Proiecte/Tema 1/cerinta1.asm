.data 
	formatcitire: .asciz "%s"
	
	hexa: .space 100
	binar: .space 400
	
	formatafisare: .asciz "%d "
	formatafisarevariabila: .asciz "%c "
	afisarerandfinal: .asciz "\n"
	formatzerospecial: .asciz "-%d "
	
	indexbinar: .long 0
	putere: .long 128
	codificare: .long 0
	doi: .long 2
	indexfinal: .long 11
	contor: .long 0

	let: .asciz "let "
	add: .asciz "add "
	sub: .asciz "sub "
	mul: .asciz "mul "
	div: .asciz "div "
	
.text

.global main

main:

// citim sirul hexa

citire:
	push $hexa
	push $formatcitire
	call scanf
	pop %ebx
	pop %ebx

// mutam sirul hexa intr-un vector pentru a parcurge element cu element

mutare:
	movl $hexa, %edi 
	movl $binar, %esi
	xorl %ecx, %ecx

parcurgere:
	movb (%edi, %ecx, 1), %al
	
	cmp $0, %al
	je mutare2
	
	cmp $48, %al
	je conversie0
	
	cmp $49, %al
	je conversie1
	
	cmp $50, %al
	je conversie2
	
	cmp $51, %al
	je conversie3
	
	cmp $52, %al
	je conversie4
	
	cmp $53, %al
	je conversie5
	
	cmp $54, %al
	je conversie6
	
	cmp $55, %al
	je conversie7
	
	cmp $56, %al
	je conversie8
	
	cmp $57, %al
	je conversie9
	
	cmp $65, %al
	je conversieA
	
	cmp $66, %al
	je conversieB
	
	cmp $67, %al
	je conversieC
	
	cmp $68, %al
	je conversieD
	
	cmp $69, %al
	je conversieE
	
	cmp $70, %al
	je conversieF
	
continuareparcurgere:
	incl %ecx
	jmp parcurgere
	
// conversii din baza 16 in baza 2

conversie0:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie1:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie2:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie3:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie4:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie5:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie6:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie7:
	pushl %ecx
	movl indexbinar, %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie8:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversie9:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversieA:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversieB:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere

conversieC:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversieD:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversieE:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $48, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
conversieF:
	pushl %ecx
	movl indexbinar, %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl $49, (%esi, %ecx, 1)
	incl %ecx
	movl %ecx, indexbinar
	popl %ecx
	jmp continuareparcurgere
	
// incepem prelucrarea sirului binar

mutare2:
	xorl %eax, %eax 
	xorl %ecx, %ecx
	movl $binar, %edi 
	
parcurgere2:
	addl $11, contor 
	
	movb (%edi, %ecx, 1), %al
	
	cmp $0, %al
	je afisarefinal

	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %al
	je numarsauvariabila
	
	cmp $49, %al
	je operatie
	

numarsauvariabila:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %al
	je numar
	
	cmp $49, %al
	je variabila

numar:
	incl %ecx
	movb (%edi, %ecx, 1), %al
	
	cmp $48, %al
	je numarpozitiv
	
	cmp $49, %al
	je numarnegativ
	
numarpozitiv: 
	incl %ecx
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
	
	cmp contor, %ecx
	je afisare
	jmp numarpozitiv
	
numarnegativ:
	incl %ecx
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
	
	cmp contor, %ecx
	je transformare
	jmp numarnegativ
	

transformare:
	cmp $0, codificare
	je cazulzero
	
	xorl %edx, %edx
	movl $-1, %edx
	movl codificare, %eax
	imul %edx
	movl %eax, codificare
	xorl %eax, %eax
	jmp afisare

variabila: 
	incl %ecx
	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je calcularevariabila
	
calcularevariabila:
	incl %ecx
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
	
	cmp contor, %ecx
	je afisarevariabila
	jmp calcularevariabila
	
operatie: 
	incl %ecx
	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je continuareoperatie

continuareoperatie: 
	incl %ecx
	movb (%edi, %ecx, 1), %al
	cmp $48, %al
	je calculareoperatie
	
calculareoperatie:
	incl %ecx
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
	
	cmp contor, %ecx
	je compararioperatie
	jmp calculareoperatie
	
cazulzero: 
	pushl codificare
	pushl $formatzerospecial
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2
	
// afisam fiecare element 

afisare: 
	pushl codificare
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2
	
afisarevariabila: 
	pushl codificare
	pushl $formatafisarevariabila
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2
	
compararioperatie: 
	movl $0, %edx
	cmp codificare, %edx
	je afisarelet
	
	movl $1, %edx
	cmp codificare, %edx
	je afisareadd
	
	movl $2, %edx
	cmp codificare, %edx
	je afisaresub
	
	movl $3, %edx
	cmp codificare, %edx
	je afisaremul
	
	movl $4, %edx
	cmp codificare, %edx
	je afisarediv
	
afisarelet:
	pushl codificare
	pushl $let
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2

afisareadd:
	pushl codificare
	pushl $add
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2

afisaresub:
	pushl codificare
	pushl $sub
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2
	
afisaremul:
	pushl codificare
	pushl $mul
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2

afisarediv:
	pushl codificare
	pushl $div
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	xorl %edx, %edx
	movl $1, %edx
	movl contor, %ecx
	add %edx, %ecx
	movl %ecx, contor
	xorl %edx, %edx
	movl $128, putere
	movl $0, codificare
	xorl %eax, %eax
	
	jmp parcurgere2

afisarefinal:
	pushl $afisarerandfinal
	call printf	
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
exit:
	mov $1, %eax
	mov $0, %ebx
	int $0x80
	
