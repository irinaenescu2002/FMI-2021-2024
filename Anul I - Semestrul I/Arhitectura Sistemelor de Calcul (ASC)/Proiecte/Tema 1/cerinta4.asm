.data
	matrice: .space 1600
	spatiu: .asciz " "
	res: .space 4
	formatafisare: .asciz "%d "
	formatafisarespatiu: .asciz "\n"
	atoires: .space 4
	
	numarlinii: .space 4
	numarcoloane: .space 4
	indexelement: .space 4
	pozitie: .long 0
	
	vectormatrice: .space 1600
	numarelemente: .space 4
	indexmatrice: .long 0
	vectorbaza: .space 1600
	minusunu: .long -1
	numarescu: .space 4
	rezultat: .space 4
	mamaluideecx: .long 0
	
.text

.global main

main:

citire:
	push $matrice
	call gets
	pop %ebx
	
strtokx:
	push $spatiu
	push $matrice
	call strtok
	pop %ebx
	pop %ebx
	
	movl %eax, res
	
atoix:
	push res
	call atoi
	pop %ebx

	xorl %eax, %eax
	
linii: 
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	mov %eax, res
	
	push res
	call atoi
	pop %ebx
	
	mov %eax, numarlinii
	
	pushl numarlinii
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
coloane: 
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	mov %eax, res
	
	push res
	call atoi
	pop %ebx
	
	mov %eax, numarcoloane
	
	pushl numarcoloane
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
elemente: 
	movl numarcoloane, %eax
	movl numarlinii, %ebx
	mul %ebx
	movl %eax, numarelemente
	xorl %ebx, %ebx

initializarevectorbaza:
	xorl %ecx, %ecx
	movl $vectorbaza, %edi
	
initializare:
	cmp numarelemente, %ecx
	je mutarevectormatrice
	movl minusunu, %edx
	movl %edx, (%edi, %ecx, 4)
	xorl %edx, %edx
	incl %ecx
	jmp initializare
	
	xorl %ecx, %ecx
	
mutarevectormatrice: 
	movl numarelemente, %eax
	cmp indexmatrice, %eax
	je stimmatricea
	
strtoku:
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	movl %eax, res
	
atoiu:
	push res
	call atoi
	pop %ebx

	movl pozitie, %ecx
	movl %eax, (%edi, %ecx, 4)
	add $1, pozitie
	add $1, indexmatrice
	
	jmp mutarevectormatrice
	
stimmatricea:
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	movl %eax, res
	
	push res
	call atoi
	pop %ebx
	
	movl %eax, numarescu

	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	movl %eax, res
	
	movl res, %esi 
	xorl %ecx, %ecx

	movb (%esi, %ecx, 1), %al
	
	xorl %ecx, %ecx
	
	cmp $97, %al
	je add
	
	cmp $115, %al
	je sub
	
	cmp $109, %al
	je mul
	
	cmp $100, %al
	je div
	
add: 
	movl mamaluideecx, %ecx
	cmp %ecx, numarelemente
	je exit 
	movl (%edi, %ecx, 4), %eax
	add numarescu, %eax
	movl %eax, rezultat
	
	pushl rezultat
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	add $1, mamaluideecx
	jmp add
	
sub: 
	movl mamaluideecx, %ecx
	cmp %ecx, numarelemente
	je exit 
	movl (%edi, %ecx, 4), %eax
	sub numarescu, %eax
	movl %eax, rezultat
	
	pushl rezultat
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	add $1, mamaluideecx
	jmp sub
	
mul: 
	movl mamaluideecx, %ecx
	cmp %ecx, numarelemente
	je exit 
	movl (%edi, %ecx, 4), %eax
	movl numarescu, %ebx
	imul %ebx
	movl %eax, rezultat
	
	pushl rezultat
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	add $1, mamaluideecx
	jmp mul
	
div: 
	xorl %edx, %edx
	movl mamaluideecx, %ecx
	cmp %ecx, numarelemente
	je exit 
	movl (%edi, %ecx, 4), %eax
	movl numarescu, %ebx
	cdq
	idiv %ebx
	movl %eax, rezultat
	
	pushl rezultat
	pushl $formatafisare
	call printf	
	popl %ebx
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	add $1, mamaluideecx
	jmp div
	
exit: 
	pushl $formatafisarespatiu
	call printf	
	popl %ebx
	
	push $0
	call fflush
	pop %ebx
	
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
