assume cs:codesg
codesg segment
    mov ax,2000h
    mov ss,ax
    mov sp,0
    add sp,4
    pop ax
    pop bx
    push ax
    push bx
    pop ax
    pop bx
    mov ax,4c0h
    int 21h
codesg ends
end