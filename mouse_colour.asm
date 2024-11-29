; graphics_mode
	mov ax, 0			; Set graphics mode 13h (320x200 pixels, 256 colors)
	mov al, 13h
	int 10h

;loop initialize
	MOV AX, 0A000h
	MOV DS, AX			; Set DS to the video memory segment
	mov AX, 0			; initialize mouse
	int 33h
	mov AX, 1			; show mouse
	int 33h
loop_condition:
	CMP BX, 2			; if right click
	JE loop_end
;loop body
	; input
		MOV AX, 0			; AX needs to be 0 for 16h
		INT 16h
		MOV AH, 0			; removes formatting
	; early exit if return/enter key
		CMP AX, 13
		JE loop_end
	; ascii formatting
		SUB AL, '0'			; ascii to int
		PUSH AX
	; mouse coords
		MOV AX, 3			; mouse interrupts
		INT 33H
		MOV AX, 320			; calculating x, y coordinates
		MUL DX
		ADD AX, CX
		MOV DI, AX			; puts the coordinates to a valid register
	; change color
		POP AX				; colour based on previous input
		MOV [DS:DI], AL
loop_update:
	jmp loop_condition	; loop
loop_end:

; sets back to text mode
	mov AH, 0
	mov AL, 03h
	int 10h

INT 020
