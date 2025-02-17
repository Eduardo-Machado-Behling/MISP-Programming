# Questão 1:
#
# Escreva um programa que altere uma string para “capitalizar” a última letra de cada palavra. Por
# exemplo, a entrada
#
# .data
# 	string: .asciiz "eu sou aluno do centro de desenvolvimento tecnologico da ufpel"
#
# deve produzir a string:
# 	"eU soU alunO dO centrO dE desenvolvimentO tecnologicO dA ufpeL"
#
# Assuma que a string de entrada possui apenas espaços e letras minúsculas. Pode haver mais de um espaço entre
# as palavras. A resposta deve ser a string de entrada modificada, e não uma nova string na memória, ou seja,
# iniciando no endereço de memória 0x10010000.

.data
	string: .asciiz "eu sou aluno do centro de desenvolvimento tecnologico da ufpel"

.text
main:
	la $s0, string
	
while:
	lb $t0, 0($s0)
	
	beq $t0, ' ', if
	beqz $t0, if
	j ifEnd
if:
	sub $t1, $s0, 1
	lb $t2, ($t1)
	addi $t2, $t2, -32
	sb $t2, ($t1)
ifEnd:

	addi $s0, $s0, 1
	bnez $t0, while
whileEnd:
	
	# syscall: print_str
	li $v0, 4
	la $a0, string
	syscall
	
	#syscall: exit
	li $v0, 10
	syscall
