MOV AL, ' '                  ; Set to nonbreaking space  
mov DS, 0b800h               ; Set DS to the video memory segment

mov SI, 0                    ; initialize SI to 0
loop_start:
    mov [DS:SI], AL          ; Write nonbreaking space to video memory
    add SI, 2                ; Increment SI (move to next character position)
    cmp SI, 4000	     ; Compare SI with 4000 (screen size in terms of bytes)
    jg end_loop              ; Jump to end if SI > 4000
    jmp loop_start           ; Jump back to loop_start if SI <= 4000

end_loop:
    INT 20h                  ; Terminate program
