# Escreva um programa que calcule o fatorial de n.
# O valor de n deve ser lido da memória na posição 0x10010000 e o valor de n! deve
# ser escrito na posição seguinte na memória (0x10010004).

.macro EXIT(%returnCode)
	ori $v0, $zero, 17
	ori $a0, $zero, %returnCode
	syscall
.end_macro

.data
	.word 0

.eqv vetor $fp
.eqv i $s0
.eqv product $s1
.eqv n $s2

.text
main:
	lui vetor, 0x1001
	ori i, $zero, 1
	ori product, $zero, 1
	lw n, 0(vetor)

loop:
	sub $t0, n, i  
	bltz $t0, end      # needed for: `while(i <= n)`
	
	mul product, product, i
	
	addi i, i, 1
	j loop

end:
	sw product, 4(vetor)
	EXIT(0)