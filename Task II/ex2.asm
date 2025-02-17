# Questão 2:
#
# Escreva um programa que inverta a ordem dos elementos de um vetor (.word) com 5 posições. Por exemplo,
# a entrada: 1, 2, 3, 4, 5 deve produzir 5, 4, 3, 2, 1. A resposta deve ser o vetor de entrada modificado,
# e não um novo vetor na memória, ou seja, iniciando no endereço de memória 0x10010000.

.data
vectorSize: .word 5
vector: .word 1, 2, 3, 4, 5
startMsg: .asciiz "Array on before:\n"
endMsg: .asciiz "Array on after:\n"

.text
main:
	lw $s0, vectorSize
	la $s1, vector
	subi $s0, $s0, 1
	sll $t0, $s0, 2
	add $s2, $s1, $t0
	
	la $a0, startMsg
	la $a1, vector
	lw $a2, vectorSize
	jal print_arr
	
while:
	bleu $s2, $s1, whileEnd
	lw $a0, ($s1)
	lw $a1, ($s2)
	
	jal swap_xor
	
	sw $a0, ($s1)
	sw $a1, ($s2)
	
	addi $s1, $s1, 4
	subi $s2, $s2, 4
	j while
whileEnd:
	la $a0, endMsg
	la $a1, vector
	lw $a2, vectorSize
	jal print_arr
	
	#syscall: exit
	li $v0, 10
	syscall

# $a0: msg, $a1: vectorAddr, $a2: vectorSize
print_arr:
	li $v0, 4
	syscall
	
	li $t9, 0
print_arr__while:
	beq $t9, $a2, print_arr__whileEnd
	li $v0, 1
	lw $a0, ($a1)
	syscall
	
	li $v0, 11
	li $a0, ' '
	syscall
	
	addi $a1, $a1, 4
	addi $t9, $t9, 1
	j print_arr__while
print_arr__whileEnd:
	li $v0, 11
	li $a0, '\n'
	syscall
	
	jr $ra

# $a0, $a1 for args
swap_xor:
	xor $a0, $a1, $a0
	xor $a1, $a0, $a1
	xor $a0, $a1, $a0
	jr $ra
