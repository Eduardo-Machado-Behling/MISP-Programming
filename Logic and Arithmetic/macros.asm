.macro HALT
	# calls syscall exit
	ori $v0, $zero, 10
	syscall
.end_macro