# Questão 1:
# Escrever um algoritmo que leia as 3 notas dos alunos, calcule a média e escreva sua média e situação
# acadêmica. Suponha a seguinte tabela apoiada no regimento da universidade para indicar o situação final do
# aluno. Faça com que o programa fique em laço e pergunte ao usuário quando deseja sair, por exemplo, Digite
# 0 para continuar ou 1 para sair. Use chamadas de sistema para entrada de notas, escrita da média e situação
# acadêmica, bem como sair do laço e encerrar o programa.
#
# | Situação  | Condição       |
# | Reprovado | media < 3      |
# | Exame     | 3 <= media < 7 |
# | Aprovado  | media >= 7     |

.macro read_int(%reg)
	li $v0, 5
	syscall
	move %reg, $v0
.end_macro

.macro read_float(%reg)
	li $v0, 6
	syscall
	mov.s %reg, $f0
.end_macro

.macro print_stra(%addr)
	la $a0, %addr
	li $v0, 4
	syscall
.end_macro

.macro print_intr(%reg)
	move $a0, %reg
	li $v0, 1
	syscall
.end_macro

.macro print_floatr(%reg)
	li $v0, 2
	mov.s $f12, %reg
	syscall
.end_macro

.macro exit()
	li $v0, 10
	syscall
.end_macro

.data
continue_msg: .asciiz "Entre 1 para sair:\n"
nota_msg_start: .asciiz "Entre a nota #"
nota_msg_end: .asciiz ":\n"
media_msg: .asciiz "Sua média é "
situation_msg: .asciiz ", Portanto você esta "
aprovado_msg: .asciiz "aprovado\n"
reprovado_msg: .asciiz "reprobado\n"
exame_msg: .asciiz "exame\n"
input_prompt: .asciiz ">>> "
zero: .float 0.0

fail: .float 3.0
exame: .float 7.0

.text
main:
	li $s0, 0
	j promptEnd
while:
	print_stra(continue_msg)
	print_stra(input_prompt)
	read_int($s0)
promptEnd:
	beq $s0, 1, whileEnd
	
	li $t0, 0
	l.s $f4, zero
for:
	beq $t0, 3, forEnd
	print_stra(nota_msg_start)
	print_intr($t0)
	print_stra(nota_msg_end)
	print_stra(input_prompt)
	read_float($f1)

	add.s $f4, $f4, $f1
	addi $t0, $t0, 1
	j for
forEnd:
	sw $t0, ($sp)
	lwc1 $f1, ($sp)
	cvt.s.w $f1, $f1
	div.s $f4, $f4, $f1
	print_stra(media_msg)
	print_floatr($f4)
	print_stra(situation_msg)
	
	l.s $f0, fail
	c.lt.s $f4, $f0
	bc1t switchPass
	l.s $f0, exame
	c.lt.s $f4, $f0
	bc1t switchTest
    j switchPass
switchFail:
	print_stra(reprovado_msg)
	j while
switchTest:
	print_stra(exame_msg)
	j while
switchPass:
	print_stra(aprovado_msg)
	j while
whileEnd:
	exit()

