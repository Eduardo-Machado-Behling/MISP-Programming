# Fa�a um programa que calcule o seguinte polin�mio usando o m�todo de Horner:
# y = 9a^3 - 5a^2 + 7a + 15
# Utilize endere�os de mem�ria para armazenar o valor de a e o resultado y. Cada
# valor deve ocupar 4 bytes na mem�ria (.word), assim como para o resultado (.space
# 4). Utilize as duas primeiras posi��es da mem�ria .data para armazenar,
# consecutivamente, a e y, iniciando o c�digo com:
# .data
# 	a: .word 3
# 	y: .space 4
# Observe como o m�todo de Horner � mais eficiente (faz menos opera��es) que
# calcular o polin�mio de forma sequencial.

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