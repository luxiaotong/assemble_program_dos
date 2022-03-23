assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
    db 16 dup(0)
datasg ends

stacksg segment stack
    db 16 dup (0)
stacksg ends

codesg segment
start:
    mov ax, stacksg
    mov ss, ax
    mov sp, 16
    mov ax, datasg
    mov ds, ax
    mov si, 0
    mov ax, 0b800h
    mov es, ax
    
    mov ax, 12666
    call dtoc

    mov dh, 8
    mov dl, 3
    mov cl, 2
    mov si, 0
    call show_str

    mov ax, 4c00h
    int 21h

dtoc:
    mov cx, 0
    push cx

    loop0:
        ; dx:ax/cx = ax(%dx)
        mov dx, 0
        mov cx, 10
        div cx

        push dx

        mov cx, ax
        jcxz loop1

        jmp short loop0

    loop1:
        pop cx
        jcxz ok

        add cl, 30h
        mov ds:[si], cl
        inc si
        jmp short loop1

    ok:
        ret

show_str:
    ; row position
    mov al, dh
    mov bl, 160
    mul bl
    mov di, ax
    ; column position
    mov al, dl
    mov bl, 2
    mul bl
    add di, ax
    ; offset
    mov bx, si
    mov al, bl
    mov bl, 2
    mul bl
    add di, ax

    ; write word
    mov al, ds:[si]
    mov byte ptr es:[di], al
    ; write color
    mov byte ptr es:[di+1], cl

    ; jmp or ret
    push cx
    mov cl, al
    mov ch, 0
    jcxz ok2
    inc si
    pop cx
    jmp short show_str

    ok2:
        pop cx
        ret

codesg ends

end start