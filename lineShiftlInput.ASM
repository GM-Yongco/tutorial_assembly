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

shiftLine:						; uses AX as start location and BX as end locations
	shiftCharactersInitialize:
		MOV DI, AX				; initialize (first index of line) 	
		ADD DI, 158
		MOV AH, b[DS: DI]		; get value of last index
		SUB DI, 158
	shiftCharactersLoop:		; does a sorta swap to shift each character
		MOV AL, b[DS: DI]		; store the current index val
		MOV b[DS: DI], AH		; put AH in current index 
		MOV AH, AL				; put AL in AH
	shiftCharactersCondition:
		ADD DI, 2				; increment
		CMP DI, BX				; condition
		JL shiftCharactersLoop	; loop
	callDelay:
		PUSH DI					; temporaroly use DI for delay
		call delay
		POP DI
	ret

main:

MOV AX, 160			; start location of the shift
MOV BX, AX
ADD BX, 160			; end location of the shift
call shiftLine

INT 020
