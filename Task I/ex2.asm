# Questão 2: 
# Encontre a soma dos números múltiplos de 3 contidos no seguinte intervalo
# de valores: 1,2,3...,299,300

.data
soma: .space 4

.text
main:

# this value because we need i > 300
# and i is incremented by 3 everytime,
# so we need i == 303 on beq.
.eqv VALUE_END 303

.eqv END $s2
.eqv I $s1
.eqv SUM $s7
.eqv DATA $s0

	ori I, $zero, 0
	ori SUM, $zero, 0
	lui DATA, 0x1001
	ori END, $zero, VALUE_END

while:
	beq I, END, whileEnd
	
	add SUM, SUM, I
	
	addi I, I, 3
	j while
whileEnd:
	sw SUM, 0(DATA)
	
	# print float
	ori $v0, $zero, 1
	or $a0, $zero, SUM
	syscall
	
	# print newline
	ori $v0, $zero, 11
	ori $a0, $zero, 0x20
	syscall