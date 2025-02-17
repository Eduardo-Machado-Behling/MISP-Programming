# 2. Escreva um programa que altere uma string para “capitalizar” a primeira letra de cada
# palavra. Por exemplo, a entrada:
#
# .data
# 	string: .asciiz "meu professor é muito bom"
#
# deve produzir a string:
# 	"Meu Professor É Muito Bom"
#
# Assuma que a entrada possui apenas espaços e letras minúsculas. Pode haver mais de
# um espaço entre as palavras.
# A resposta deve ser a string de entrada modificada, e não uma nova string na
# memória, ou seja, iniciando no endereço de memória 0x10010000.


.data
	string: .asciiz "meu professor é muito bom"
	
.text
main:
.eqv STR $s0
.eqv I $s1
.eqv OFFSET $s2
.eqv CHAR $s3

	la STR, string
	la OFFSET, string
	li I, 0
	
	lbu $t0, (OFFSET)
	subi $t0, $t0, 32
	sb $t0, (OFFSET)
for:
	addi OFFSET, OFFSET, 1
	lbu CHAR, (STR)
	beq CHAR, $zero, endFor
	
	bne CHAR, 0x20, endIf
	lbu $t0, (OFFSET)
	subi $t0, $t0, 32
	sb $t0, (OFFSET)
endIf:
	addi STR, STR, 1
	j for
endFor:	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall