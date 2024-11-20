MOV AL, 'A'
MOV DS, 0b800h			; Set DS to the video memory segment

JMP main

delay:
	MOV SI, 0			; index for slow delay
delayLoop:
	INC SI				; increment
	CMP SI, 32767		; loop if SI is less than
	JL delayLoop 
	ret

main:
	MOV DI, 0			; Set DI to Display Index
print:
	MOV b[DS: DI], AL	; print
	call delay			; delay
	
	ADD DI, 2			; increment
	CMP DI, 160			; condition (loop if DI less 160)
	JL print			; repeat

INT 020
