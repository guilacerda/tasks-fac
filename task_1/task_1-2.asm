.data
	space: .asciiz "\n" # Cria uma label que armazena uma string (no caso, quebra de linha)
.text

	li $t1, 0x0000FACE # Insere o conteúdo no registrador $t1
	li $t2, 0xFFFF0F0F # Insere o conteúdo no registrador $t2
	la $t6, space # Carrega imediatamente o conteúdo definido pela label "space" no registrador $t6
	
	srl $t3, $t1, 4 # Desloca o registrador 1 byte pra direita obtendo o valor 0x00000FAC
	sll $t3, $t3, 28 # Desloca o registrador em 7 bytes para a esquerda obtendo o valor 0xC0000000
	srl $t3, $t3, 16 # Descloca o registrador em 4 bytes para a direita, obtendo o valor necessário

	srl $t4, $t1, 12 # Desloca o registrador em 3 bytes para a direita
	sll $t4, $t4, 4  # Desloca em 1 byte para a esquerda o registrador e obtém o valor 0x000000F0

	and $t5, $t1, $t2 # Realiza a operação AND entre o registrador $t1 e $t2, armazenando no registrador $t5
	or $t5, $t5, $t3 # Realiza a operação OR entre o registrador $t5 e $t3, armazenando no registrador $t5
	or $t5, $t5, $t4 # Realiza a operação AND entre o registrador $t5 e $t4, armazenando no registrador $t5

	li $v0, 34 # Carrega imediatamente a função 34 (imprimir em hexadecimal) no registrador $v0
	move $a0, $t1 #  Copia o valor armazenado no registrador $t1 para o registrador $a0
	syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0
	
	li $v0, 4 # Carrega imediatamente a função 4 (imprimir string) no registrador $v0
	move $a0, $t6 # Copia o valor do "\n" contido no registrador $t6 para o primeiro argumento de retorno $a0
	syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0

	li $v0, 34 # Carrega imediatamente a função 34 (imprimir em hexadecimal) no registrador $v0
	move $a0, $t5 # Copia o valor armazenado no registrador $t5 para o registrador $a0
	syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0
