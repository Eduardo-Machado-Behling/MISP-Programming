# Escreva um programa que calcule o número de bits significativos de um número
# inteiro positivo. Inicie o programa com a instrução ori $t1, $0, x, substituindo x pelo
# valor desejado. Armazene o resultado final no registrador $t2.

.macro EXIT(%returnCode)
	ori $v0, $zero, 17
	ori $a0, $zero, %returnCode
	syscall
.end_macro

.eqv num $t1
.eqv count $t2

.text
main:
	ori num, $zero, 0xCACA
	ori count, $zero, 0

loop: 
	beq num, $zero, end
	
	srl num, num, 1
	
	addi count, count, 1
	j loop

end:
	ori $v0, $zero, 1
	or $a0, $zero, count
	syscall
	
	EXIT(0)