.data

	value_message: .asciiz "A raiz cubica é "
	response_dot: .asciiz "."
	error_message: .asciiz " O erro eh menor que "

	var_0: .float 0.0
	var_1: .float 1.0
	var_2: .float 2.0
	var_erro: .float 0.0000001

.text

	main:
		li $v0, 6 # Lê o valor a ser calculada a raiz em float
		syscall
		mov.s $f2, $f0 # n = $f2

		l.s $f30, var_2 # Armazena o valor 2.0 para fazer a busca binária

		l.s $f4, var_0 # É o intervalo inicial para a procura do valor através da busca binária

		l.s $f6, var_1 # É o intervalo final para a procura do valo através da busca binária
		add.s $f6, $f6, $f2 # Incrementa o valor inserido com 1 (end = 1 + n) para definir o intervalo correto para a busca da raiz

		l.s $f8, var_erro # Valor requerido para o erro = 0.0000001 

		j calc_raiz 

	calc_raiz:

		add.s $f10, $f4, $f6 # Adiciona o valor do intervalo inicial ao valor final para a realiação da busca binária
		div.s $f10, $f10, $f30 # Divide o valor adicionado em 2 para saber da aproximação da raiz

		j calc_erro

	calc_erro:

		l.s $f14, var_1 # Inicializa um valor neutro para a multiplicação $f14 = 1
		
		# Multiplica 3 vezes o valor desejado para encontrar o cubo do valor
		mul.s $f14, $f14, $f10 
		mul.s $f14, $f14, $f10
		mul.s $f14, $f14, $f10

		c.le.s $f2, $f14 # Compara se o n é menor que o resultado do cubo do valor resultante da busca binária. return (n - (mid^3))
		bc1f return_1 # Se for falso
		bc1t return_2 # Se for verdadeiro 

	return_1:

		sub.s $f16, $f2, $f14 # Subtrai o valor do cubo de mid ao 'n'
		j continua_raiz_cubica

	return_2:

		sub.s $f16, $f14, $f2 # Subtrai o valor de n ao cubo de mid
		j continua_raiz_cubica

	continua_raiz_cubica:

		c.le.s $f16, $f8 # Compara se o valor resultante da subtração anterior é menor do que o erro desejado
		bc1t fim # Caso positivo, finalize o cálculo

		l.s $f14, var_1 # Inicializa a variável para o cálculo do cubo do valor
		
		# Realiza 3 operações de multiplicação para encontrar o valor ao cubo
		mul.s $f14, $f14, $f10
		mul.s $f14, $f14, $f10
		mul.s $f14, $f14, $f10

		c.lt.s $f2, $f14 # Compara se o n é menor do que o valor resultante do cubo
		bc1t atualiza_fim # Caso positivo, atualiza o limite final
		bc1f atualiza_inicio # Caso negativo, atualiza o limite inicial

	atualiza_fim:

		mov.s $f6, $f10 # Atualiza $f6 que é o valor do limite final com o valor encontrado da busca binária
		j calc_raiz

	atualiza_inicio:
		mov.s $f4, $f10 # Atualiza $f4 que é o valor do limite inicial com o valor encontrado da busca binária
		j calc_raiz

	fim:
		# Imprime o texto armazenado em value_message
		li $v0, 4
		la $a0, value_message
		syscall

		# Imprime o valor da raiz cúbica encontrado
		li $v0, 2
		mov.s $f12, $f10
		syscall

		# Imprime o texto armazenado em response_dot
		li $v0, 4
		la $a0, response_dot
		syscall

		# Imprime o texto armazenado em error_message
		li $v0, 4
		la $a0, error_message
		syscall

		# Imprime o valor associado ao erro obtido através do cálculo
		li $v0, 2
		mov.s $f12, $f16
		syscall
