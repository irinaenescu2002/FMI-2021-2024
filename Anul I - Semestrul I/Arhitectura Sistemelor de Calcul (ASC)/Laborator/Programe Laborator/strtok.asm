.data
	sir: .asciz "78 8 let 6 add -9 sub 5"
	spatiu: .asciz " "
	res: .space 4
	formatafisare: .asciz "%s\n"
	
.text

.global main

main:
	push $spatiu
	push $sir
	call strtok
	pop %ebx
	pop %ebx
	
	movl %eax, res
	
	push res
	push $formatafisare
	call printf
	pop %ebx
	pop %ebx
	
parcurgere:
	push $spatiu
	push $0
	call strtok
	pop %ebx
	pop %ebx
	
	cmp $0, %eax
	je exit
	
	mov %eax, res
	
	push res
	push $formatafisare
	call printf
	pop %ebx
	pop %ebx
	
	jmp parcurgere
	
exit: 
	mov $1, %eax
	mov $0, %ebx
	int $0x80
