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
				
		jal calcula_raiz

		addi $t4, $zero, 2 # Inicia no valor 2
	
		jal verifica_primo
	
	
	calcula_raiz:
		
		#-------------------------------#
		# Registradores utilizados	#
		# $t1 => A			#
		# $t2 => B			#
		# $t3 => C			#
		#-------------------------------#
		
		#-------------------------------#
		# Processo a ser realizado: 	#
		# C = B				#
		# B = (B/2)			#
		# B = B + A/(B*2)		#
		#-------------------------------#

		move $t3, $t2 # C = B		
		divu $t4, $t2, 2 # B/2
		mul $t5, $t2, 2 # B*2
		divu $t5, $t1, $t5 # A/(B*2)
		add $t2, $t4, $zero # B/2 + 0
		add $t2, $t2, $t5 # B/2 + A/(B*2)
			
	verifica_raiz:
		bne $t2, $t3, calcula_raiz
		
		jr $ra				
	
	verifica_primo:
		# $t4 => contador de 1 até o valor da raiz
		
		beq $t4, $s3, calc_exp
		div $s3, $t4
		mfhi $t5
		beq $t5, $zero, imprime_erro
		
		addi $t4, $t4, 1
		j verifica_primo
	
	calc_exp:
	# Passo 1 - Divida o segundo valor em potências de 2
	# Passo 2 - Calcule o mod do terceiro valor com as potências de 2
	# Passo 3 - Use propriedades de multiplicação modular para combinar os valores calculados

		j imprime_saida
			
	imprime_erro:
		li $v0, 4
		
		la $a0, failure_message
		syscall
		
		la $a0, finish_message
		syscall
		
		j end
	
	imprime_saida:
	

		j end
	
	end:
