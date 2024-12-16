# Escreva um programa que calcule o produt�rio abaixo. O valor de n deve ser lido da
# posi��o 0x10010000 da mem�ria no in�cio do programa. O valor de A deve ser
# escrito na mem�ria no fim do programa, na posi��o 0x10010004.
#
# Product i=0 -> n (n + i/2)
#
# OBS: considere a divis�o inteira, i.e.:
# 1 / 2 = 0,
# 2 / 2 = 1,
# 3 / 2 = 1,
# 4 / 2 = 2, etc.



.macro EXIT(%returnCode)
	ori $v0, $zero, 17
	ori $a0, $zero, %returnCode
	syscall
.end_macro

.data
	.word 7

.eqv n $s0
.eqv i $s1
.eqv vetor $fp
.eqv constTwo $s2
.eqv product  $s3

.text
main:
	ori i, $zero, 0
	ori product, $zero, 1
	lui vetor, 0x1001
	lw n, 0(vetor)
	ori constTwo, $zero, 2

loop:
	srl $t0, i, 1
	add $t1, $t0, n
	mul product, product, $t1
	addi i, i, 1
	bne i, n, loop
	
	sw product, 4(vetor)
	EXIT(0)