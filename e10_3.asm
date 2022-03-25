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
    
    ; mov ax, 12666
    ; call dtoc

    mov ax, 42cah
    mov dx, 000ch
    call ddtoc

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
    push si

    mov bx, 0
dtoc_div:
    ; dx:ax/cx = ax(%dx)
    mov dx, 0
    mov cx, 10
    div cx

    push dx
    inc bx

    mov cx, ax
    jcxz dtoc_change

    jmp short dtoc_div

dtoc_change:
    mov cx, bx
dtoc_write:
    pop ax
    add al, 30h
    mov ds:[si], al
    inc si
    loop dtoc_write
dtoc_ret:
    pop si
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

; 输入: ; 低位被除数: ax, 高位被除数: dx, 字符串在ds起始位置: si
ddtoc:
    push ax
    push bx
    push cx
    push dx
    push si

    mov bx, 0
ddtoc_div:
    ; dx:ax/cx = ax(%dx)
    mov cx, 10
    call divdw

    push cx
    inc bx

    mov cx, ax
    add cx, dx
    jcxz ddtoc_change

    jmp short ddtoc_div

ddtoc_change:
    mov cx, bx
ddtoc_write:
    pop ax
    add al, 30h
    mov ds:[si], al
    inc si
    loop ddtoc_write
    mov byte ptr ds:[si], 0
ddtoc_ret:
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret


; 输入: 低位被除数: ax, 高位被除数: dx 除数: cx
; 输出: 低位结果: ax, 高位结果: dx, 余数 cx
divdw:
    push bx
    
    push ax; L

    mov ax, dx ; dx=H
    mov dx, 0
    div cx ; cx=N
    ;div 结果: ax=int(H/N), dx=rem(H/N)
    
    mov bx, ax
    
    pop ax; ax=L
    div cx

    mov cx, dx
    mov dx, bx

    pop bx    
    ret

codesg ends

end start