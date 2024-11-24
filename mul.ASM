MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

delay:
	MOV DX, 0FFFFh	; index for slow delay
delayLoop:
	DEC DX				; increment
	JNZ delayLoop 
	ret

main:

multiply:		; takes AX*BX = AX; and remainder as DX
	MOV AX, 16
	MOV BX, 4
	MUL BX	

print:		; takes DI as input on how many times to print
	MOV DI, 0
	print_condition:
		CMP DI, AX			; exit condition (loop if DI less AX)
		JGE print_end
	print_body:
		MOV b[DS: DI], 'A'	; print
		call delay			; delay
	print_increment:
		ADD DI, 2			; increment
		jmp print_condition	; loop
	print_end:

INT 020
