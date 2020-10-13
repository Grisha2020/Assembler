.data
	shablon1: .asciz "%d + %d = %d\n"
	k_1: .asciz "2, 2, 4"
	shablon2: .asciz "Hello, %s!\n"
	k_2: .asciz "Ivan"
	shablon21: .asciz "Hello, %s and %s!\n"
	k_2_1: .asciz "Egor"
	shablon3: .asciz "Sale! -80%%\n"
.text
	li s1, '%'
	li s2, '\0'
	li s3, '\n'
	li s4, 'd'
	li s5, 's'
	
	la a0, shablon3
	call printf
	
	la a0, shablon2
	la a1, k_2
	call printf
	
	la a0, shablon21
	la a1, k_2
	la a2, k_2_1
	call printf
	
	li a7, 10
	ecall
	
	
printf:
	addi sp, sp, -24
	sw ra, 12(sp)
	sw a2, 8(sp)
	sw a1, 4(sp)
	sw a0, 0(sp)
	
	lw a6, 0(sp)
	mv t0, sp

loop:
	lb a0, (a6)
	beq a0, s1, prochent
	beq a0, s3, pri_char
	beq a0, s2, end_f
	li a7, 11
	ecall
	addi a6, a6, 1
	b loop

prochent:
	lb a1, 1(a6)
	addi a6, a6, 1
	beq a1, s1, pri_char
	beq a1, s5, pri_stri
	b loop
	
pri_char:
	li a7, 11
	ecall
	addi a6, a6, 1
	b loop
	
pri_stri:
	addi t0, t0, 4
	lw a0, (t0)
	li a7, 4
	ecall
	addi a6, a6, 1
	b loop
	
end_f:
	lw ra, 12(sp)
	addi sp, sp, 24
	ret
	


