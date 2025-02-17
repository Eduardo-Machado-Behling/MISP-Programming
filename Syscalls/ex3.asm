# 3. Escreva um programa que leia um vetor de 10 posições (.word) da memória
# (começando na posição 0x10010000) e verifique se o vetor está ou não ordenado.
# Use o registrador $t0 como flag.
#
# Faça $t0 = 1 se o vetor estiver ordenado e $t0 = 0 caso contrário.

.data
vectorSize: .word 10
vector: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

.text
main:
.eqv VECTOR_SIZE $s0
.eqv IINDEX $s1
.eqv JINDEX $s2

	la $t6, vectorSize
	lw VECTOR_SIZE, ($t6)
	mul VECTOR_SIZE, VECTOR_SIZE, 4
	addi VECTOR_SIZE, VECTOR_SIZE, 4
	add VECTOR_SIZE, VECTOR_SIZE, $t6
	la IINDEX, vector
	la JINDEX, vector
	li $t0, 1
for:
	addi JINDEX, JINDEX, 4
	beq JINDEX, VECTOR_SIZE, endFor
	
	lw $t1, (IINDEX)
	lw $t2, (JINDEX)
	
	bgt $t2, $t1, endIf
	li $t0, 0
	j endFor
endIf:

	addi IINDEX, IINDEX, 4
	j for
endFor:
	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 10
	syscall
	