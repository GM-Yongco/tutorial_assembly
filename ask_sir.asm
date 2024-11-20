~^
#ERROR messages will be removed if you leave these first two lines in     @@@@#
MOV AL, 'A'
MOV DS, 0b800h			; Set DS to the video memory segment

JMP main

slow:
	MOV SI, 0		; index for slow delay
delay:
	INC SI			; increment
	CMP SI, 32767		; jump if SI
	JL delay 
	ret

main:
	MOV DI, 0		; Set SI to Display Index
print:
	MOV b[DS: DI], AL	; print
	
	push a
	call slow		; delay
	pop a
~	     ^
#ERROR 21: Bad Single Operand                                             @@@@#
	
	
	ADD DI, 2		; increment
	CMP DI, 160		; condition (jump if DI less 160)
	JL print		; repeat

INT 020
