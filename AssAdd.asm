MOV AL, 'A'
mov ds, 0b800h; Set DS to the video memory segment
mov si, 0
mov b[ds:si], AL; using byte offsets, in the video memory segmet, offset of value si by label/offset of byte then put al in there
add si, 2
inc AL
mov b[ds: si], AL

INT 020
