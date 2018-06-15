.data

	value_message: .asciiz "A raiz cubica é "
	response_dot: .asciiz "."
	error_message: .asciiz " O erro eh menor que "

	var_0: .double 0.0
	var_1: .double 1.0
	var_2: .double 2.0
	var_erro: .double 0.0000001

.text

	main:
		li $v0, 7
		syscall
		mov.d $f2, $f0 # n = $f2

		l.d $f30, var_2

		l.d $f4, var_0 # start = 0

		l.d $f6, var_1 # end = 1
		add.d $f6, $f6, $f2 # end = 1 + n

		l.d $f8, var_erro # erro = 0.0000001

		j calc_raiz

	calc_raiz:

		add.d $f10, $f4, $f6
		div.d $f10, $f10, $f30 # mid = $f10

		j calc_erro

	calc_erro:

		l.d $f14, var_1
		mul.d $f14, $f14, $f10
		mul.d $f14, $f14, $f10
		mul.d $f14, $f14, $f10

		c.le.d $f2, $f14 # return (n - (mid^3))
		bc1f return_1
		bc1t return_2

	return_1:

		sub.d $f16, $f2, $f14
		j continua_raiz_cubica

	return_2:

		sub.d $f16, $f14, $f2
		j continua_raiz_cubica

	continua_raiz_cubica:

		c.le.d $f16, $f8
		bc1t fim

		l.d $f14, var_1
		mul.d $f14, $f14, $f10
		mul.d $f14, $f14, $f10
		mul.d $f14, $f14, $f10

		c.lt.d $f2, $f14
		bc1t atualiza_fim
		bc1f atualiza_inicio

	atualiza_fim:

		mov.d $f6, $f10
		j calc_raiz

	atualiza_inicio:
		mov.d $f4, $f10
		j calc_raiz

	fim:

		li $v0, 4
		la $a0, value_message
		syscall

		li $v0, 3
		mov.d $f12, $f10
		syscall

		li $v0, 4
		la $a0, response_dot
		syscall

		li $v0, 4
		la $a0, error_message
		syscall

		li $v0, 3
		mov.d $f12, $f16 # Imprime o valor associado ao erro obtido através do cálculo
		syscall
