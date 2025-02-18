# Questão 2:
# Ler um valor inteiro, armazenar este valor no registrador ($t0) e escrever a tabuada do valor lido.
# Use chamadas de sistema para entrada e saída de dados.

.macro read_int(%reg)
	li $v0, 5
	syscall
	move %reg, $v0
.end_macro

.macro print_stra(%addr)
	la $a0, %addr
	li $v0, 4
	syscall
.end_macro

.macro print_chari(%char)
	li $a0, %char
	li $v0, 11
	syscall
.end_macro

.macro print_intr(%reg)
	move $a0, %reg
	li $v0, 1
	syscall
.end_macro

.macro exit()
	li $v0, 10
	syscall
.end_macro

.macro PUSH.W(%reg)
	sw %reg, ($sp)
	addi $sp, $sp, -4
.end_macro

.macro PUSHI.W(%value)
	li $v1, %value    
	PUSH.W($v1)
.end_macro

.macro POP.W(%reg)
	addi $sp, $sp, 4
	lw %reg, ($sp)
.end_macro

.data
prompt_numero: .asciiz "Entre o numero para gerar a tabuada:\n"
input_cursor: .asciiz ">>> "
cell_size: .word 10

.text
main:
	print_stra(prompt_numero)
	print_stra(input_cursor)
	read_int($s0)            # changed to $s0, because temporaries are changed in functions
	
	li $s1, 1
	lw $s4, cell_size
	move $s3, $s0
	
	PUSH.W($s4)
	PUSHI.W(2)
	PUSHI.W(0)
	jal print_border
for:
	beq $s1, 11, forEnd

	PUSH.W($s4)    #cellSize
	PUSH.W($s0)    # a
	PUSH.W($s1)	   # b
	jal print_mult
	
	PUSH.W($s4)    #cellSize
	PUSH.W($s3)    # res
	jal print_res
	
	print_chari('\n')
	
	addi $s1, $s1, 1
	add $s3, $s3, $s0
	
	j for
forEnd:
	PUSH.W($s4)
	PUSHI.W(2)
	PUSHI.W(1)
	jal print_border
	
	move $t0, $s0           # it is in $t0 now :P
	exit()

# (cellSize: word, cellAmount: word, footer: word) -> void
print_border:
	POP.W($t8)  # footer
	POP.W($t1)  # cellAmount
	POP.W($t0)  # cellSize


	li $t3, 0
	
	addi $t0, $t0, 2
__print_border_forCell:
	print_chari(' ')
	beq $t3, $t1, __print_border_forCellEnd

	li $t4, 0
__print_border_forInnerCell:
	beq $t4, $t0, __print_border_forInnerCellEnd
	
	bnez $t8, __print_border_forCell__ifFooter
	print_chari('_')
	j __print_border_forCell__ifEnd
__print_border_forCell__ifFooter:
	print_chari(175)
__print_border_forCell__ifEnd:
	addi $t4, $t4, 1
	j __print_border_forInnerCell
__print_border_forInnerCellEnd:

	addi $t3, $t3, 1
	j __print_border_forCell
__print_border_forCellEnd:
	print_chari('\n')
	jr $ra
	

# (cellSize: word, a: word, b: word) -> void
print_mult:
	POP.W($t2)  # b
	POP.W($t1)  # a
	POP.W($t0)  # cellSize
	
	PUSH.W($ra)
	PUSH.W($s0) # saved to restore
	PUSH.W($s1) # saved to restore
	PUSH.W($s2) # saved to restore
	PUSH.W($s3) # saved to restore
	
	move $s0, $t0
	move $s1, $t1
	move $s2, $t2
	
	print_chari('|')
	print_chari(' ')
	
	PUSH.W($s1)
	jal get_digit_amount
	POP.W($s3)
	
	PUSH.W($s2)
	jal get_digit_amount
	POP.W($t2)
	add $s3, $s3, $t2
	addi $s3, $s3, 1
	
	sub $t3, $s0, $s3
	bgez $t3, __print_mult_skipClamp
	move $t3, $zero
__print_mult_skipClamp:
	li $t4, 0
	andi $t5, $t3, 1
	beqz $t5, __print_mult_even
	addi $t4, $t4, -1
__print_mult_even:
	srl $t3, $t3, 1
	
	li $t6, 1
__print_mult_forPadding:
	beq $t4, $t3, __print_mult_forPaddingEnd
	print_chari(' ')
	
	addi $t4, $t4, 1
	j __print_mult_forPadding
__print_mult_forPaddingEnd:
	beqz $t6, __print_mult_return
	print_intr($s1)
	print_chari('*')
	print_intr($s2)
	li $t6, 0
	li $t4, 0
	j __print_mult_forPadding
__print_mult_return:
	print_chari(' ')
	print_chari('|')

	POP.W($s3) # restore
	POP.W($s2) # restore
	POP.W($s1) # restore
	POP.W($s0) # restore

	POP.W($ra)
	jr $ra
	
# (cellSize: word, res: word) -> void
print_res:
	POP.W($t0)  # res
	POP.W($t1)  # cellSize
	
	PUSH.W($ra)
	PUSH.W($s0) # saved to restore
	PUSH.W($s1) # saved to restore
	
	move $s0, $t0
	move $s1, $t1
	
	print_chari(' ')
	
	PUSH.W($s0)
	jal get_digit_amount
	POP.W($t2)
	
	sub $t3, $s1, $t2
	bgez $t3, __print_res_skipClamp
	move $t3, $zero
__print_res_skipClamp:
	li $t4, 0
	andi $t5, $t3, 1
	beqz $t5, __print_res_even
	addi $t4, $t4, -1
__print_res_even:
	srl $t3, $t3, 1
	
	li $t6, 1
__print_res_forPadding:
	beq $t4, $t3, __print_res_forPaddingEnd
	print_chari(' ')
	
	addi $t4, $t4, 1
	j __print_res_forPadding
__print_res_forPaddingEnd:
	beqz $t6, __print_res_return
	print_intr($s0)
	li $t6, 0
	li $t4, 0
	j __print_res_forPadding
__print_res_return:
	print_chari(' ')
	print_chari('|')

	POP.W($s1)
	POP.W($s0)

	POP.W($ra)
	jr $ra
	
	
#(digits: word) -> amount: word
get_digit_amount:
	POP.W($t0)   #digits
	
	beqz $t0, __get_digit_zero_case
	
	li $t1, 0
__get_digit_amount_for:
	beqz $t0, __get_digit_amount_forEnd
	
	div $t0, $t0, 10
	addi $t1, $t1, 1
	j __get_digit_amount_for
__get_digit_amount_forEnd:
	PUSH.W($t1)
	jr $ra
__get_digit_zero_case:
	PUSHI.W(1)
	jr $ra




