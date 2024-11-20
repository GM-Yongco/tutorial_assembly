mov ds, 0b800h      ; Set DS to the video memory segment

MOV AH, 'A'
mov si, 0
mov b[ds:si], AH    ; using byte offsets, in the video memory segmet, offset of vAHue si by label/offset of byte then put AH in there
add si, 2
inc AH
mov b[ds: si], AH

INT 020
