# Questão 2

.data

	space: .asciiz "\n" # Cria uma label na qual armazena uma quebra de linha

.text

	li $t1, 0x0000FACE # Insere imediatamente o conteúdo 0x0000CABE no registrador $t1
	li $t0, 0x00000000 # Insere imediatamente o conteúdo 0x00000000 no registrador $t0

	li $v0, 34 # Carrega a função 34 (impressão em hexadecimal) no registrador $v0
	move $a0, $t1 # Copia o valor do registrador $t1 para o argumento $a0
	syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0

	la $t9, space # Copia o conteúdo da label space no registrador $t9

	li $v0, 4 # Carrega a função 4 (impressão de string) no registrador $v0
	move $a0, $t9 # Copia o valor do registrador $t9 para o argumento $a0
	syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0

	srl $t2, $t1, 12 # Movimenta os 4 bits (1111) em 3 posições de memória para a direita
									 # tornando-os como os bits menos significativos
	sll $t2, $t2, 4 # Movimenta os últimos 4 bits em 1 posição de memória para a esquerda
									# Alocando-o corretamente na posição solicitada do exercício

	srl $t3, $t1, 4 # Movimenta os 4 bits (1100) em 1 posições de memória para a direita
									# tornando-os como os bits menos significativos
	sll $t3, $t3, 28 # Movimenta os últimos 4 bits (1100) em 7 posição de memória para a esquerda
									 # zerando todos os bits desnecessários
	srl $t3, $t3, 16 # Movimenta os 4 bits (1100) em 4 posições de memória para a direita
									 # alocando-o na posição solicitada pelo exercício

	sll $t4, $t1, 28 # Movimenta os bits menos significativos em 7 posição de memória para a esquerda
									 # zerando todos os bits desnecessários
	srl $t4, $t4, 28 # Movimenta os 4 bits mais significativos em 7 posições de memória para a direita
									 # tornando-os como os bits menos significativos

	srl $t5, $t1, 8 # Movimenta os 4 bits (0010) em 2 posições de memória para a direita
									# tornando-os como os bits menos significativos
	sll $t5, $t5, 28 # Movimenta os últimos 4 bits (0010) em 7 posição de memória para a esquerda
									 # zerando todos os bits desnecessários
	srl $t5, $t5, 20 # Movimenta os 4 bits mais significativos (0010) em 5 posições de memória para a direita
									 # alocando-o na posição solicitada pelo exercício

	or $t6, $t0, $t2 # Implementa a operação booleana "or" bit-a-bit entre os registradores $t0 e $t2
	 								 # e armazena no registrador $t6 Ex: 00000000000000000000000011110000 or 00000000000000000000000000000000
	or $t6, $t6, $t3 # Implementa a operação booleana "or" bit-a-bit entre os registradores $t6 e $t3
	 								 # e armazena no registrador $t6
	or $t6, $t6, $t4 # Implementa a operação booleana "or" bit-a-bit entre os registradores $t6 e $t4
	 								 # e armazena no registrador $t6
	or $t6, $t6, $t5 # Implementa a operação booleana "or" bit-a-bit entre os registradores $t6 e $t5
	 								 # e armazena no registrador $t6

	li $v0, 34 # Carrega a função 4 (impressão de string) no registrador $v0
	move $a0, $t6 # Copia o valor do registrador $t6 para o argumento $a0
	syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0
