# Uma temperatura, armazenada em $t0, pode ficar em dois intervalos:
# 	20 ? temp ? 40 e
# 	60 ? temp ? 80.
# Escreva um programa que coloque uma flag (registrador $t1) para 1 se a
# temperatura está entre os valores permitidos e para 0 caso contrário.
# Inicie o código com a instrução: ori $t0, $zero, temperatura, substituindo
# temperatura por um valor qualquer.


.macro exit(%exitCode)
	addi $a0, $zero, %exitCode
	ori $v0, $zero, 17
	syscall
.end_macro 

.macro ReadInteger(%integerReg)
	ori $v0, $zero, 5
	syscall
	or %integerReg, $zero, $v0
.end_macro 
	
.text
main:
.eqv temp $t0
.eqv lowerBoundBegin $s1
.eqv boundsSpan $s2
.eqv upperBoundBegin $s3

	ori temp, $zero, 30
	ReadInteger(temp)
	ori lowerBoundBegin, $zero, 20
	ori boundsSpan, $zero, 20
	ori upperBoundBegin, $zero, 60
	
	sub $t2, temp, lowerBoundBegin
	sub $t3, $t2, boundsSpan
	blez $t3, true
	
	sub $t2, temp, upperBoundBegin
	sub $t3, $t2, boundsSpan
	blez $t3, true

false:
	ori $t1, $t1, 0
	j end
true:
	bltz $t2, false
	ori $t1, $t1, 1
	j end

end:
	exit(0)