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
    push ax
    push bx
    push cx
    push dx

    mov bx, 0
div_push:
    ; dx:ax/cx = ax(%dx)
    mov dx, 0
    mov cx, 10
    div cx

    push dx
    inc bx

    mov cx, ax
    jcxz toc

    jmp short div_push

toc:
    mov cx, bx
pop_loop:
    pop ax
    add al, 30h
    mov ds:[si], al
    inc si
    loop pop_loop
dtoc_ret:
    pop dx
    pop cx
    pop bx
    pop ax
    ret


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