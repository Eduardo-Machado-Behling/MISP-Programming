# Escreva um programa que repetidamente pergunte ao usuário pelo número de
# quilômetros viajados e litros de gasolina consumidos e depois imprima o número de
# quilômetros por litro. Para sair do programa, o usuário deve digitar 0 como número
# de quilômetros.
#
# Armazene todos os números de quilômetros por litro na memória, iniciando pelo
# endereço 0x10010000. 

.data
MSG_KM: .asciiz "Entre os kilometros corridos: "
MSG_LT: .asciiz "Entre a quantidades de litros de gasolina: "
MSG_RES: .asciiz "Km/L = "
ZERO: .word 0
SAVE: .space 4

.text
main:
.eqv DATA $s0
.eqv FZERO $f31
.eqv LT $f1
.eqv KM $f2
.eqv KM_PER_LT $f12

	la DATA, SAVE
	lwc1  FZERO, ZERO
	cvt.s.w FZERO, FZERO

while:
	li $v0 4
	la $a0, MSG_KM
	syscall
	
	li $v0 6
	syscall
	mov.s KM, $f0
	
	c.eq.s KM, FZERO
	bc1t whileEnd
	
	li $v0 4
	la $a0, MSG_LT
	syscall
	li $v0 6
	syscall
	mov.s LT, $f0
	
	li $v0 4
	la $a0, MSG_RES
	syscall
	div.s KM_PER_LT, KM, LT
	li $v0, 2
	syscall
	li $v0, 11
	li $a0, 10
	syscall
	
	swc1 KM_PER_LT, 0(DATA)
	addi DATA, DATA, 4
	
	j while
whileEnd:
	li $v0, 10
	syscall
	
	
