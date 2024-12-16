# Escreva um programa que leia um valor x > 0 da memória (posição 0x10010000) e
# calcule o x-ésimo termo da série de Fibonacci:
# 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...
# Escreva o x-ésimo termo da série (y) em uma palavra (4 bytes) de memória. O
# resultado deve ser armazenado, obrigatoriamente, na posição 0x10010004 da
# memória .data. Inicie o código com:
# .data
# 	x: .word 7
#	y: .space 4

.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro

.data
 	x: .word 7
	y: .space 44
	
.text
main:
.eqv data $fp
.eqv prevNumReg $s0
.eqv currNumReg $s1
.eqv i $s2
.eqv x $s3

	lui data, 0x1001
	lw x, 0(data)
	ori i, $zero, 0
	ori prevNumReg, $zero, 0
	ori currNumReg, $zero, 1
	ori i, $zero, 1
	
loop:
	beq i, x, end
	
	# swap(prev, curr)
	xor prevNumReg, prevNumReg, currNumReg
	xor currNumReg, currNumReg, prevNumReg
	xor prevNumReg, prevNumReg, currNumReg
	
	add currNumReg, currNumReg, prevNumReg

	addi i, i, 1
	j loop
end:
	sw currNumReg, 4(data)
	exit(0)