MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

delay:
	MOV DX, 0FFFFh	; index for slow delay
delayLoop:
	DEC DX				; increment
	JNZ delayLoop 
	ret

main:

divide:		; takes AX/BX = AX; and remainder as DX
	MOV DX, 0       ; for some reason the program crashes if DX isnt cleared
    MOV AX, 30
	MOV BX, 5
	DIV BX	

; note, the number of printed "A" is half the result of division 
print:		; takes AX as input on how many times to print
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
