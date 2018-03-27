.data

.text

	li $t1, 0x0000FACE # Insere o conteúdo no registrador $t1
	li $t2, 0xFFFF0F0F # Insere o conteúdo no registrador $t2

	srl $t3, $t1, 4 # Desloca o registrador 1 byte pra direita obtendo o valor 0x00000FAC
	sll $t3, $t3, 28 # Desloca o registrador em 7 bytes para a esquerda obtendo o valor 0xC0000000
	srl $t3, $t3, 16 # Descloca o registrador em 4 bytes para a direita, obtendo o valor necessário

	srl $t4, $t1, 12 # Desloca o registrador em 3 bytes para a direita
	sll $t4, $t4, 4  # Desloca em 1 byte para a esquerda o registrador e obtém o valor 0x000000F0

	and $t5, $t1, $t2 # Realiza a operação AND entre o registrador $t1 e $t2, armazenando no registrador $t5
	or $t5, $t5, $t3 # Realiza a operação OR entre o registrador $t5 e $t3, armazenando no registrador $t5
	or $t5, $t5, $t4 # Realiza a operação AND entre o registrador $t5 e $t4, armazenando no registrador $t5
