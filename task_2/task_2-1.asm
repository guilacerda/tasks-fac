.data

	sucess_message_1: .asciiz "A exponencial modular "
	sucess_message_2: .asciiz " elevado a "
	sucess_message_3: .asciiz " (mod "
	sucess_message_4: .asciiz ") eh "
	
	failure_message: .asciiz "O modulo nao eh primo"
	
	finish_message: .asciiz ".\n"

.text
	#----------------------------------------------------------------#
	#            Registradores reservados para a atividade 		 #
	#----------------------------------------------------------------#
	# $v0 => destinado ao syscall para construir as funções		 #
	# $a0 => destinado ao syscall para passagem de parâmetros	 #
	#----------------------------------------------------------------#
	# $s1 => armazena o primeiro valor em inteiro			 #
	# $s2 => armazena o segundo valor em inteiro			 #
	# $s3 => armazena o terceiro valor em inteiro			 #
	# $s4 => armazena o valor da raiz para descobrir o primo	 # 
	#----------------------------------------------------------------#
	# $t6 => destinado a todas as mensagens de sucesso		 #
	# $t7 => destinado a todas as mensagens de fracasso		 #
	#----------------------------------------------------------------#
	# $f2 => valor convertido do primeiro inteiro para double	 #
	# $f4 => valor convertido do segundo inteiro para double 	 #
	#----------------------------------------------------------------#

	le_inteiro:
	
		li $v0, 5
		syscall
		move $s1, $v0  # Valor que será tratado como a base
	
		li $v0, 5
		syscall
		move $s2, $v0 # Valor que será tratado como o expoente
		
		li $v0, 5
		syscall
		move $s3, $v0 # Valor que será tratado como módulo
		
	eh_primo:
	# Aplicar divisão para descobrir se um número é primo

		move $t1, $s3 # A = A
		move $t2, $s3 # B = A
				
		jal calcula_raiz # Chama o método para calcular a raiz do valor inserido

		addi $t4, $zero, 2 # Inicia no valor 2
		move $s4, $t3 # Copia o valor da raiz para o registrador $s4
	
		jal verifica_primo # Chama o método para verificar se o valor é primo
	
	
	calcula_raiz:
		
		#-------------------------------#
		#  Método para calcular a raiz  #
		#-------------------------------#
		# Registradores utilizados:	#
		# $t1 => A			#
		# $t2 => B			#
		# $t3 => C			#
		#-------------------------------#
		# Processo a ser realizado: 	#
		# Passo 1 => C = B		#
		# Passo 2 => B = (A/B)		#
		# Passo 3 => B = (B + A/B)	#
		# Passo 4 => B = (B + A/B)/2	#
		#-------------------------------#

		move $t3, $t2 # C = B (Passo 1)
		
		div $t1, $t2 # Divide 
		mflo $t4 # Recebe o quociente de A/B (Passo 2)
		
		add $t5, $t4, $zero # Inicializa $t5 com o quociente obtido anteriormente
		add $t5, $t5, $t2 # Soma o quociente com o valor de B (Passo 3)
		
		li $t4, 0x02 # Inicializa uma variável temporária com o valor 2
		div $t5, $t4 # Divide a soma do quociente da divisão de A/B + B por 2
		
		mflo $t5 # Recebe o quociente de (B + A/B)/2

		move $t2, $t5 # Move o resultado da divisão completa para o registrador $t2 (Passo 4)

	verifica_raiz:
		bne $t2, $t3, calcula_raiz # Se B != C, ou seja, se a raiz aproximada não foi encontrada,
					   # chama o processo de calcular a raiz novamente
		
		jr $ra	# Retorna ao ponto após a chamada na label eh_primo
	
	verifica_primo:
		# $t4 => contador de 1 até o valor da raiz
		
		div $s3, $t4 # Divide o valor inserido para o módulo pelo contador
		mfhi $t5 # Obtém o resto da divisão anterior
		beq $t5, $zero, imprime_erro # Verifica se o resto é zero, se for, o valor não é primo

		beq $t4, $s4, calc_exp # Se o contador chegar até o limite da raiz, 
				       # então calcula a exponencial modular
				
		addi $t4, $t4, 1 # Incrementa mais 1 no contador
		j verifica_primo # Realiza o processo recursivo da verificação dos primos
	
	calc_exp:
	
	#-----------------------------------------------------------------------------------------------#
	#		Processo para calcular a exponencial modular de forma rápida			#
	#-----------------------------------------------------------------------------------------------#
	# Passo 1 => Divida o segundo valor em potências de 2						#
	# Passo 2 => Calcule o mod do terceiro valor com as potências de 2				#
	# Passo 3 => Use propriedades de multiplicação modular para combinar os valores calculados	#
	#-----------------------------------------------------------------------------------------------#
	
		j imprime_saida # Chama o método de imprimir a saída correta
			
	imprime_erro:
		li $v0, 4
		
		la $a0, failure_message # Carrega a mensagem de falha, onde identifica o valor não-primo
		syscall # Chama a função de imprimir uma string
		
		la $a0, finish_message # Carrega o valor \n. para finalizar a mensagem
		syscall # Chama a função de imprimir uma string
		
		j end # Chama o método para finalizar o programa
	
	imprime_saida:
	

		j end # Chama o método para finalizar o programa
	
	end:
		li $v0, 10 # Insere o código da função para sair do programa
		syscall # Chama a função para finalizar o programa

