# Questão 2

.data

	space: .asciiz "\n"

.text

	li $t1, 0x0000CABE
	li $t0, 0x00000000
	
	li $v0, 34
	move $a0, $t1
	syscall
	
	la $t9, space

	li $v0, 4
	move $a0, $t9
	syscall
	
	srl $t2, $t1, 12 # armazena os 4 bits mais significativos 1111
	sll $t2, $t2, 4
																								
	srl $t3, $t1, 4 # armazena 1100
	sll $t3, $t3, 28
	srl $t3, $t3, 16
	
	sll $t4, $t1, 28
	srl $t4, $t4, 28
	
	srl $t5, $t1, 8
	sll $t5, $t5, 28
	srl $t5, $t5, 20
	
	or $t6, $t0, $t2
	or $t6, $t6, $t3
	or $t6, $t6, $t4
	or $t6, $t6, $t5
	
	li $v0, 34
	move $a0, $t6
	syscall