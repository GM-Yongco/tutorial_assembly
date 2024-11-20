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
	PUSH DX						; doesnt overwrite on DX if ever theres data there
	multiplyInitialize:
		MOV DX, 0				; how many times we have added BX to CX
		MOV CX, 0				; make sure CX is empty
	multiplyLoop:
		ADD CX, BX
	multiplyCondition:
		INC DX					; increment
		CMP DX, AX				; condition
		JL multiplyLoop			; loop
	POP DX
	ret

main:
	PUSH AX
	PUSH BX

	MOV AX, 2
	MOV BX, 160
	call multiply

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
