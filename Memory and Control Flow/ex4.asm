# Escreva um programa que leia dois halfwords (a e b) da memória e calcule a sua
# divisão se os dois valores forem diferentes e a sua multiplicação se os dois valores
# forem iguais. Escreva o resultado (y) em uma palavra (4 bytes) de memória. O
# resultado deve ser armazenado, obrigatoriamente, na posição 0x10010004 da
# memória .data. Inicie o código com:
# .data
# 	a: .half 30
#	b: .half 5
#	y: .space 4


.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro

.data
 	a: .half 30
	b: .half 5
	y: .space 4
	
.text
main:
.eqv data $fp
.eqv aReg $s0
.eqv bReg $s1

	lui data, 0x1001
	lh aReg, 0(data)
	lh bReg, 2(data)
	
	beq aReg, bReg, equals
	div aReg, bReg
	mflo $t0
	j end
equals:
	mul $t0, aReg, bReg
end:
	sw $t0, 4(data)
	exit(0)