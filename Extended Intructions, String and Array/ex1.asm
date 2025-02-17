# Escreva um programa que remova os espaços de uma string. Por exemplo, a entrada
# .data
# 	string: .asciiz “Gosto muito do meu professor de AOC-I."
#
# deve produzir a string:
# 	" GostomuitodomeuprofessordeAOC-I.“
#
# Use apenas uma string (não use uma string de saída ou uma string auxiliar no seu
# programa). Não esqueça de terminar sua string com nulo (ver tabela ASCII para
# código do espaço e do \0 (null)).
#
# A resposta deve ser a string de entrada modificada, e não uma nova string na
# memória, ou seja, iniciando no endereço de memória 0x10010000.

.data
	string: .asciiz "Gosto muito do meu professor de AOC-I."
	
.text
main:
.eqv STR $s0
.eqv I $s1
.eqv OFFSET $s2
.eqv CHAR $s3

	la STR, string
	la OFFSET, string
	li I, 0
	
for:
	lbu CHAR, (STR)
	beq CHAR, $zero, endFor
	
	beq CHAR, 0x20, endIf
	sb CHAR, (OFFSET)
	addi OFFSET, OFFSET, 1
endIf:
	addi STR, STR, 1
	j for
endFor:
	sb $zero, (OFFSET)
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall