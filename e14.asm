assume cs:codesg

codesg segment
start:
    mov al, 9
    out 70h, al
    in al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl
    and al, 00001111b
    add ah, 30h
    add al, 30h

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+40*2], ah
    mov byte ptr es:[160*12+40*2+2], al

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+42*2], 47

    mov al, 8
    out 70h, al
    in al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl
    and al, 00001111b
    add ah, 30h
    add al, 30h

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+43*2], ah
    mov byte ptr es:[160*12+43*2+2], al

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+45*2], 47

    mov al, 7
    out 70h, al
    in al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl
    and al, 00001111b
    add ah, 30h
    add al, 30h

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+46*2], ah
    mov byte ptr es:[160*12+46*2+2], al

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+48*2], 32

    mov al, 4
    out 70h, al
    in al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl
    and al, 00001111b
    add ah, 30h
    add al, 30h

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+49*2], ah
    mov byte ptr es:[160*12+49*2+2], al

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+51*2], 58

    mov al, 2
    out 70h, al
    in al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl
    and al, 00001111b
    add ah, 30h
    add al, 30h

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+52*2], ah
    mov byte ptr es:[160*12+52*2+2], al

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+54*2], 58

    mov al, 0
    out 70h, al
    in al, 71h
    mov ah, al

    mov cl, 4
    shr ah, cl
    and al, 00001111b
    add ah, 30h
    add al, 30h

    mov bx, 0b800h
    mov es,bx
    mov byte ptr es:[160*12+55*2], ah
    mov byte ptr es:[160*12+55*2+2], al

    mov ax, 4c00h
    int 21h

codesg ends
end start