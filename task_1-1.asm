# Questão 1

.data
	
	space: .asciiz "\n" # Cria uma label que armazena uma string (no caso, quebra de linha)

.text

	main: 
		la $t6, space # Carrega imediatamente o conteúdo definido pela label "space" no registrador $t6
																				
		li $t1, 0x55555555 # Insere imediatamente o conteúdo no registrador $t1

		sll $t2, $t1, 1 # Desloca 1 bit à esquerda do valor armazenado no registrador $t1
		or $t3, $t1, $t2 # Realiza a operação OR entre o registrador $t1 e $t2, armazenando no registrador $t3
		and $t4, $t1, $t2 # Realiza a operação AND entre o registrador $t1 e $t2, armazenando no registrador $t4
		xor $t5, $t1, $t2 # Realiza a operação XOR entre o registrador $t1 e $t2, armazenando em $t5
	
		# Imprime o valor armazenado no registrador $t1 na forma hexadecimal
	
		li $v0, 34	# Carrega imediatamente a função 35 (impressão em hexadecimal) no registrador $v0
		move $a0, $t1 # Move o valor setado no registrador $t1 para o primeiro argumento de retorno $a0
		syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0
		
		# Imprime o "\n"
			
		jal break_line
						
		# Imprime o valor armazenado no registrador $t2 na forma hexadecimal									
							
		li $v0, 34 # Carrega imediatamente a função 35 (impressão em hexadecimal) no registrador $v0
		move $a0, $t2 # Move o valor setado no registrador $t2 para o primeiro argumento de retorno $a0
		syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0
	
		# Imprime o "\n"
	
		jal break_line

		# Imprime o valor armazenado no registrador $t3 na forma hexadecimal

		li $v0, 34 # Carrega imediatamente a função 35 (impressão em hexadecimal) no registrador $v0
		move $a0, $t3 # Move o valor setado no registrador $t3 para o primeiro argumento de retorno $a0
		syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0

		# Imprime o "\n"

		jal break_line

		# Imprime o valor armazenado no registrador $t4 na forma hexadecimal

		li $v0, 34 # Carrega imediatamente a função 35 (impressão em hexadecimal) no registrador $v0
		move $a0, $t4 # Move o valor setado no registrador $t4 para o primeiro argumento de retorno $a0
		syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0

		# Imprime o "\n"

		jal break_line

		# Imprime o valor armazenado no registrador $t5 na forma hexadecimal

		li $v0, 34 # Carrega imediatamente a função 35 (impressão em hexadecimal) no registrador $v0
		move $a0, $t5 # Move o valor setado no registrador $t5 para o primeiro argumento de retorno $a0
		syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0

		jal end

	break_line:
		li $v0, 4 # Carrega imediatamente a função 4 (imprimir string) no registrador $v0
		move $a0, $t6 # Move o valor do "\n" contido no registrador $t6 para o primeiro argumento de retorno $a0s
		syscall # Chama a função de ação solicitada anteriormente no registrador $v0 retornando o argumento $a0
		jr $ra

	end: