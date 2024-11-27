MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

input_as_int:				; output stored at AX as int
	; initialize
		MOV AX, 0			; stored char input
		MOV BX, 10			; because base 10
		MOV CX, 0			; as temp variable
		MOV DI, 0			; how many inputs so far
	IAI_condition:
		CMP DI, 4			; limit input to 4 digits, 16 bit int limit
		JGE IAI_end
	; body
		; input
			INT 16h
			MOV AH, 0			; removes formatting
		; early exit if return/enter key
			CMP AX, 13
			JE IAI_end
		; multiply stored input so far by 10
			PUSH AX
			MOV AX, CX
			MUL BX
			MOV CX, AX			; store again at CX
			MOV AX, 0
			POP AX
		; formatting then add to stored 
			SUB AL, '0'			; ascii to int
			ADD CX, AX
	; update
		INC DI
		JMP IAI_condition
	IAI_end:
		MOV AX, CX
		RET

main:

call input_as_int
PUSH AX
call input_as_int
POP BX
ADD AX, BX

int_to_string:
	; initialize 
		MOV DI, 0			; hold how many digits/count
		MOV BX, 10			; because base 10
	ITS_condition:
		CMP AX, 0
		JE ITS_end
	;body
		MOV DX, 0			; prep DX to receive the modulo
		DIV BX
		ADD DX, '0'			; char to ascii
		PUSH DX
	;update
		INC DI
		JMP ITS_condition
	ITS_end:

stack_to_print:
	; initialize
		MOV AX, DI			; prep AX to be condition, DX to be index 
		MOV DI, 0
		MOV BX, 2
		MUL BX				; 2 because update is  increment by 2
	print_condition:
		CMP DI, AX
		JGE print_end
	;body
		POP CX
		MOV b[DS: DI], CL	; ascii values are only on the lower 8 bits
	;update
		ADD DI, 2
		jmp print_condition
	print_end:

INT 020
