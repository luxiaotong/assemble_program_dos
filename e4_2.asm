assume cs:code
code segment
    mov ax,20h
    mov ds,ax
    mov bx,0h
    mov cx,64
    s:
        mov ds:[bx],bx
        inc bx
        loop s
    mov ax,4c0h
    int 21h
code ends
end