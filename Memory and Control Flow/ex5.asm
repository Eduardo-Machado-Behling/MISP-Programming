# Escreva um programa que calcule:
# 1 + 2 + 3 + … + 333
# Escreva o resultado (y) em uma palavra (4 bytes) de memória. O resultado deve ser
# armazenado, obrigatoriamente, na posição 0x10010000 da memória .data. Inicie o
# código com:
# .data
# 	y: .space 4

.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro

.data
	y: .space 4
	
.text
main:
.eqv data $fp
.eqv lastNumReg $s0
.eqv i $s1
.eqv sum $s2

	lui data, 0x1001
	ori i, $zero, 0
	ori sum, $zero, 0
	ori lastNumReg, $zero, 333
	
loop:
	addi i, i, 1
	
	add sum, sum, i

	beq i, lastNumReg, end
	j loop
end:
	sw sum, 0(data)
	exit(0)