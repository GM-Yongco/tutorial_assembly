MOV DS, 0b800h			; Set DS to the video memory segment
JMP main

delay:
	MOV SI, 0			; index for slow delay
delayLoop:
	INC SI				; increment
	CMP SI, 32767		; loop if SI is less than
	JL delayLoop 
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

main:
	PUSH AX
	PUSH BX

	MOV AX, 3
	MOV BX, 80
	PUSH DI
	call multiply
	POP DI

	PUSH BX
	POP AX
	
printInitialize:
	MOV DI, 0			; Set DI to Display Index
	MOV AL, 'k'
printLoop:
	MOV b[DS: DI], AL	; print
	call delay			; delay
printConditionp:
	ADD DI, 2			; increment
	CMP DI, CX			; condition (loop if DI less 160)
	JL printLoop		; repeat

INT 020
