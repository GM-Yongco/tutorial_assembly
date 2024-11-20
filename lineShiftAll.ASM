MOV DS, 0b800h			; Set DS to the video memory segment

JMP main

shiftLine:						; uses AX as start location and BX as end locations
	shiftCharactersInitialize:
		MOV DI, AX				; first index of line
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
	ret

multiply:						; AX and BX as inputs, CX as output
	multiplyInitialize:
		MOV DI, 0				; how many times we have added BX to CX
		MOV CX, 0				; make sure CX is empty
	multiplyCondition:
		CMP DI, AX				; condition
		JGE multiplyEnd			; exit
	multiplyLoop:
		ADD CX, BX
	multiplyUpdate:
		INC DI					; increment
		JMP multiplyCondition
	multiplyEnd:
	ret

shiftAll:
	shiftAllInitialize:
		MOV DI, 0				; counts and dtermines lines to be shifted
	shiftAllLoop:
		callMultiply:
			MOV AX, DI
			MOV BX, 160
			PUSH DI
			call multiply
			POP DI
		callShiftLine:
			MOV AX, CX				; start location of the shift
			MOV BX, AX
			ADD BX, 160				; end location of the shift
			
			PUSH DI
			call shiftLine
			POP DI
	shiftAllContiion:
		INC DI					; increment
		CMP DI, 25				; condition
		JL shiftAllLoop			; loop
	ret

main:
	call shiftAll
	INT 020
