MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

main:

MOV AX, 21				; the two numbers to add
ADD AX, 32

;initialize	turning the number into string 
	MOV DI, 0			; this register will hold how many digits/count
	MOV BX, 10			; because base 10
ITS_condition:
	CMP AX, 0
	JE ITS_end
;body
	MOV DX, 0			; prep DX to receive the modulo
	DIV BX
	ADD DX, 48			; 48 is ascii for zero; turns base 10 single digit value of DX to its ascii counterpart
	PUSH DX
;update
	INC DI
	JMP ITS_condition
ITS_end:

;initialize printing from the stack
	MOV AX, DI			; moves count to AX in preparation for DX to be used as index
	MOV DI, 0
	MOV BX, 2
	MUL BX				; multiplies the condition by 2 because increment by 2
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
