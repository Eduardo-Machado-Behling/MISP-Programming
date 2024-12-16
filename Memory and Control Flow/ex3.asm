# Faça um programa que calcule o seguinte polinômio usando o método de Horner:
# y = - ax^4 + bx^3 - cx^2 + dx - e
# Utilize endereços de memória para armazenar o valor de a, b, c, d, e, x e o resultado
# y. Cada valor deve ocupar 4 bytes na memória (.word), assim como para o resultado
# (.space 4). Utilize as sete primeiras posições da memória .data para armazenar,
# consecutivamente, a, b, c, d, e, x e y, iniciando o código com:
# .data
# 	a: .word -3
# 	b: .word 7
#	c: .word 5
# 	d: .word -2
# 	e: .word 8
#	x: .word 4
# 	y: .space 4.

.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro

.data
 	a: .word -3
 	b: .word 7
	c: .word 5
 	d: .word -2
 	e: .word 8
	x: .word 4
 	y: .space 4
	
.text
main:
.eqv data $fp
.eqv aReg $s0
.eqv bReg $s1
.eqv cReg $s2
.eqv dReg $s3
.eqv eReg $s4
.eqv xReg $s5


	lui data, 0x1001
	lw aReg, 0(data)
	lw bReg, 4(data)
	lw cReg, 8(data)
	lw dReg, 12(data)
	lw eReg, 16(data)
	lw xReg, 20(data)
	
	
	# x(x(x(ax + b) - c) + d) - e
	mul $t0, aReg, xReg
	add $t0, $t0, bReg
	mul $t0, $t0, xReg
	sub $t0, $t0, cReg
	mul $t0, $t0, xReg
	add $t0, $t0, dReg
	mul $t0, $t0, xReg
	sub $t0, $t0, eReg
	
	sw $t0, 24(data)
	exit(0)