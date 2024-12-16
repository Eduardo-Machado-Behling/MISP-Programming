# Faça um programa que calcule a seguinte equação:
# y = 32ab - 3a + 7b - 13
# Utilize endereços de memória para armazenar o valore de a, b e o resultado y. Cada
# valor deve ocupar 4 bytes na memória (.word), assim como para o resultado (.space
# 4). Utilize as três primeiras posições da memória .data para armazenar,
# consecutivamente, a, b e y, iniciando o código com:

.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro

.data
	a: .word 3
	b: .word 5
	y: .space 4
	
.text
main:
.eqv data $fp
.eqv aReg $s0
.eqv bReg $s1

	lui data, 0x1001
	lw aReg, 0(data)
	lw bReg, 4(data)
	
	mul $t0, aReg, bReg
	addi $t9, $zero, 32
	mul $t0, $t0, $t9
	
	addi $t9, $zero, -3
	mul $t1, aReg, $t9
	
	addi $t9, $zero, 7
	mul $t2, bReg, $t9
	
	add $t3, $t0, $t1
	add $t3, $t3, $t2
	addi $t3, $t3, -13
	
	sw $t3, 8(data)
	exit(0)