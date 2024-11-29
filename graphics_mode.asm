
mov ah, 00h			; Set graphics mode 13h (320x200 pixels, 256 colors)
mov al, 13h
int 10h

JMP main

delay:
	MOV DI, 0			; index for slow delay
delayLoop:
	INC DI				; increment
	CMP DI, 32767		; loop if DI is less than
	JL delayLoop 
	ret

main:

MOV ES, 0A000h			; Set DS to the video memory segment

;loop initialize
	MOV AL, 4			; colour red
	MOV DI, 0			; index to 0
loop_condition:
	CMP DI, 32000		; exit condition (loop if DI less AX)
	JGE loop_end
;loop body
	MOV [ES:DI], AL		; change pixel color
	PUSH DI
	CALL delay			; delay
	POP DI
loop_update:
	INC DI, 1			; increment
	jmp loop_condition	; loop
loop_end:


INT 020
