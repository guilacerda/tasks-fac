.data

.text

	li $t1, 0x0000BACE
	li $t2, 0xFFFF0F0F
	
	srl $t3, $t1, 4 # armazena C
	sll $t3, $t3, 28 
	srl $t3, $t3, 16 
	
	srl $t4, $t1, 12 # armazena F
	sll $t4, $t4, 4 
	
	and $t5, $t1, $t2
	or $t5, $t5, $t3
	or $t5, $t5, $t4 
	