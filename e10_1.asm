assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
    db 'Welcome to masm!', 0
    ; db 'W', 0
datasg ends

stacksg segment stack
    dw 8 dup (0)
    ; db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
stacksg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax
    mov ax, stacksg
    mov ss, ax
    mov sp, 16
    mov ax, 0b800h
    mov es, ax

    mov dh, 8
    mov dl, 3
    mov cl, 2
    mov si, 0
    call show_str

    mov ax, 4c00h
    int 21h

show_str:
    push dx
    push cx
    push si

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

    mov al, cl
    mov ch, 0
show:
    ; read word
    mov cl, ds:[si]
    ; return if read 0
    jcxz ok
    ; write word
    mov byte ptr es:[di], cl
    ; write color
    mov byte ptr es:[di+1], al

    inc si
    add di, 2
    jmp short show
ok:
    pop si
    pop cx
    pop dx
    ret

codesg ends

end start