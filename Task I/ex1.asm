# Questão 1:
# Escreva um programa que leia 10 palavras (words) armazenadas a partir do endereço 0x10010000 e
# calcule o somatório dos valores e a média. Escreva os valores nos respectivos endereços de memória de dados

.data
.word 1
.word 2
.word 3
.word 4
.word 5
.word 6
.word 7
.word 8
.word 9
.word 10
soma: .space 4
média: .space 4

.text
main:
.eqv NUMBER_AMOUNT 10
.eqv MEDIA $s2
.eqv I $s1
.eqv SUM $s7
.eqv MEAN $s6
.eqv DATA $s0

	ori I, $zero, 0
	ori SUM, $zero, 0
	lui DATA, 0x1001
	ori MEDIA, $zero, NUMBER_AMOUNT

while:
	beq I, MEDIA, whileEnd
	
	lw $t0, 0(DATA)
	add SUM, SUM, $t0
	
	addi I, I, 1
	addi DATA, DATA, ,4
	j while
whileEnd:
	sw SUM, 0(DATA)
	
	ori $t0, $zero, NUMBER_AMOUNT
	sw $t0, 4(DATA)
	
	
	lwc1 $f1, 0(DATA)
	cvt.s.w $f1, $f1
	lwc1 $f2, 4(DATA)
	cvt.s.w $f2, $f2
	div.s  $f12, $f1, $f2	
	swc1 $f12, 4(DATA)
	
	# print float
	ori $v0, $zero, 2
	syscall
	
	# print newline
	ori $v0, $zero, 11
	ori $a0, $zero, 0x20
	syscall
