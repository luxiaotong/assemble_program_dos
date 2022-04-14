assume cs:codesg

datasg segment
    db 'Welcome to masm!', 0
datasg ends

codesg segment
start:
    mov ax, cs
    mov ds, ax
    mov si, offset print
    mov ax, 0
    mov es, ax
    mov di, 200h
    mov cx, offset printend - offset print
    cld
    rep movsb

    mov ax, 0
    mov es, ax
    mov word ptr es:[7ch*4], 200h
    mov word ptr es:[7ch*4+2], 0
    
    mov ax, datasg
    mov ds, ax
    mov si, 0
    mov dh, 10
    mov dl, 10
    mov cl, 2
    int 7ch

    mov ax, 4c00h
    int 21h

print:
    push ax
    push bx
    push cx
    push si

show:
    mov ah, 2
    mov bh, 0
    int 10h

    cmp byte ptr [si], 0
    je ok
    
    mov ah, 9
    mov al, [si]
    mov bl, cl
    mov bh, 0
    push cx
    mov cx, 1
    int 10h
    pop cx

    inc si
    inc dl
    jmp short show

ok:
    pop si
    pop cx
    pop bx
    pop ax
    iret

printend:
    nop

codesg ends

end start