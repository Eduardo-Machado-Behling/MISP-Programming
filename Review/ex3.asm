# Escreva um programa que encontre a mediana de três valores lidos da memória. A
# mediana deve ser salva na posição 0x1001000C da memória.
# Exemplos:
# .data
# a: .word 3
# b: .word 2
# c: .word 6
#
# 	#Mediana = 3
# .data
# a: .word 19
# b: .word 9
# c: .word 6
# 	#Mediana = 9




.macro EXIT(%returnCode)
	ori $v0, $zero, 17
	ori $a0, $zero, %returnCode
	syscall
.end_macro

.data
	.word 19
	.word 9
	.word 6

.eqv vetor $fp
.eqv Areg $s0
.eqv Breg $s1
.eqv Creg $s2
.eqv swappedLastFlag $s3

.text
main:
	lui vetor, 0x1001
	ori swappedLastFlag, $zero, 0
	lw Areg, 0(vetor)
	lw Breg, 4(vetor)
	lw Creg, 8(vetor)

swapRoutine:
	sub $t0, Breg, Areg
	bltzal $t0, swapAB
	bne swappedLastFlag, $zero, end
	sub $t0, Creg, Breg
	bltzal $t0, swapBC
	bne swappedLastFlag, $zero, swapRoutine

end:
	sw Breg, 12(vetor)
	EXIT(0)

swapAB:
	xor Areg, Areg, Breg
	xor Breg, Breg, Areg
	xor Areg, Areg, Breg
	jr $ra
	
swapBC:
	ori swappedLastFlag, $zero, 1
	xor Breg, Breg, Creg
	xor Creg, Creg, Breg
	xor Breg, Breg, Creg
	jr $ra