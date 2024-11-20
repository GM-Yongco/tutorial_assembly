MOV DS, 0b800h			; Set DS to the video memory segment
MOV DI, 0				; destination index

JMP main

delay:
	MOV DI, 0			; initialize
delayLoop:
	INC DI				; increment
	CMP DI,	32767		; condition
	JL delayLoop 		; loop
	ret

shiftLine:
	shiftCharactersInitialize:
		MOV DI, 0				; initialize (first index of line) 	
		ADD DI, 158
		MOV AH, b[DS: DI]		; get value of last index
		SUB DI, 158
	shiftCharactersLoop:		; does a sorta swap to shift each character
		MOV AL, b[DS: DI]		; store the current index val
		MOV b[DS: DI], AH		; put AH in current index 
		MOV AH, AL				; put AL in AH
	shiftCharactersCondition:
		ADD DI, 2				; increment
		CMP DI, 160				; condition
		JL shiftCharactersLoop	; loop
	callDelay:
		PUSH DI					; temporaroly use DI for delay
		call delay
		POP DI
	ret

main:

MOV b[DS: 162], 'Q'				; my kind of print for debugging
call shiftLine

INT 020
