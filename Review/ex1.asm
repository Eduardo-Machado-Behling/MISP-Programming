#Reescreva o seguinte código C em MIPS Assembly:
# 	int i;
# 	int vetor[8];
# 	for(i=0; i<8; i++) {
# 		if(i%2==0)
# 			vetor[i] = i * 2;
# 		else
# 			vetor[i] = vetor[i] + vetor[i-1];
# 	}
# Cada posição do vetor deve ter 4 bytes e deve ser armazenada, em sequência, a
# partir da posição 0x1001000 da memória.


.macro EXIT(%returnCode)
	ori $v0, $zero, 17
	ori $a0, $zero, %returnCode
	syscall
.end_macro

.data
	.word 0
	.word 1
	.word 2
	.word 3
	.word 4
	.word 5
	.word 6
	.word 7

.eqv vectorSize $s7
.eqv i $s0
.eqv vetor $fp
.eqv constTwo $s1

.text
main:
	ori i, $zero, 0
	lui vetor, 0x1001
	ori constTwo, $zero, 2
	ori vectorSize, $zero, 8

loop:
.eqv currentVetorAddress $t0
.eqv currentValue $t1
.eqv remainder $t2
.eqv prevVetorAddress $t3
.eqv prevValue $t4

	sll currentVetorAddress, i, 2
	add currentVetorAddress, vetor, currentVetorAddress
	lw currentValue, 0(currentVetorAddress)
	div currentValue, constTwo
	mfhi remainder
	beq remainder, $zero, even
	addi prevVetorAddress, currentVetorAddress, -4
	lw prevValue, 0(prevVetorAddress)
	add $t5, prevValue, currentValue
	sw $t5, 0(currentVetorAddress)
	j ifend
even:
	sll $t3, i, 1 
	sw  $t3, 0(currentVetorAddress)
ifend:
	addi i, i, 1
	bne i, vectorSize, loop
	EXIT(0)