assume cs:codesg

codesg segment
start:
    mov ax, 2
    mov bx, ax

    mov cl, 1
    shl ax, cl

    mov cl, 3
    shl bx, cl
    
    add ax, bx

    mov ax, 4c00h
    int 21h

codesg ends
end start