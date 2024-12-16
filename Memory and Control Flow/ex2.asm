# Faça um programa que calcule o seguinte polinômio usando o método de Horner:
# y = 9a^3 - 5a^2 + 7a + 15
# Utilize endereços de memória para armazenar o valor de a e o resultado y. Cada
# valor deve ocupar 4 bytes na memória (.word), assim como para o resultado (.space
# 4). Utilize as duas primeiras posições da memória .data para armazenar,
# consecutivamente, a e y, iniciando o código com:
# .data
# 	a: .word 3
# 	y: .space 4
# Observe como o método de Horner é mais eficiente (faz menos operações) que
# calcular o polinômio de forma sequencial.

.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro

.data
	a: .word 3
	y: .space 4
	
.text
main:
.eqv data $fp
.eqv aReg $s0

	lui data, 0x1001
	lw aReg, 0(data)
	
	# a(a(9a - 5)+ 7) + 15
	addi $t9, $zero, 9
	mul $t0, aReg, $t9
	addi $t0, $t0, -5
	mul $t0, $t0, aReg
	addi $t0, $t0, 7
	mul $t0, $t0, aReg
	addi $t0, $t0, 15
	
	sw $t0, 4(data)
	exit(0)