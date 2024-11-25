MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

main:

int_to_str:
	MOV AX, 625		; im trying to print AX to the display
	MOV BX, 10		; because base 10
	MOV DI, 0		; this register will hold how many digits
	ITS_condition:
		CMP AX, 0
		JE ITS_end
	ITS_body:
		MOV DX, 0		; prep DX to receive the modulo
		DIV BX
		ADD DX, 48		; ascii for zero
		PUSH DX
	ITS_update:
		INC DI
		JMP ITS_condition
	ITS_end:

print:			; takes AX as input on how many times to print
	MOV AX, DI
	MOV BX, 2
	MUL BX		; multiplies the condition by 2 because increment by 2
	MOV DI, 0
	print_condition:
		CMP DI, AX
		JGE print_end
	print_body:
		POP CX
		MOV b[DS: DI], CL	; ascii values are only on the lower 8 bits
	print_update:
		ADD DI, 2
		jmp print_condition
	print_end:

INT 020
