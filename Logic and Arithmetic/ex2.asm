.include "macros.asm"

.text
main:
	lui $t7, 0xDECA
	ori $t7, $t7, 0xDA70
	
	ori $v0, $zero, 34     #syscall print integer in hexadecimal
	or $a0, $zero, $t7
	syscall
	
	HALT
