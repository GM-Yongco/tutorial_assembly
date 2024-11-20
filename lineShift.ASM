MOV DS, 0b800h			; Set DS to the video memory segment

JMP main

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
	ret

main:

MOV b[DS: 162], 'Q'				; my kind of print for debugging
call shiftLine

INT 020
