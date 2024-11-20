MOV DS, 0b800h			; Set DS to the video memory segment
MOV DI, 0				; destination index

JMP main

delay:
	MOV DI, 0			; index for slow delay
delayLoop:
	INC DI				; increment
	CMP DI,	32767		; jump if DL is less
	JL delayLoop 
	ret

main:



scroll:
	MOV SI, 0				; start line index
	MOV DI, 0				; times the line has been shifted
	PUSH DI
scrollLine:
	MOV DI, 0				; sets DI to the first index of the line	
shiftLine:
	ADD DI, 158
	MOV AH, b[DS: DI]		; first index gets last index
	SUB DI, 158
shiftLineLoop:				; does a sorta swap to shift each character
	MOV AL, b[DS: DI]
	MOV b[DS: DI], AH
	MOV AH, AL
	ADD DI, 2
	
	ADD SI, 160
	CMP DI, SI
	SUB SI, 160
	JL shiftLineLoop

callDelay:
	PUSH DI
	call delay
	POP DI
scrollLineCondition:
	POP DI
	INC DI
	CMP DI, 80
	PUSH DI
	JL shiftLine

INT 020
