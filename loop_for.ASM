MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

main:

print:		; takes AX as input on how many times to print
	MOV DI, 0
	MOV AX, 162
	print_condition:
		CMP DI, AX			; exit condition (loop if DI less AX)
		JGE print_end
	print_body:
		MOV b[DS: DI], 'A'	; print
	print_increment:
		ADD DI, 2			; increment
		jmp print_condition	; loop
	print_end:

INT 020
