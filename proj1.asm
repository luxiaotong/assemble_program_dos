assume cs:codesg, ss:stacksg, ds:datasg

datasg segment
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1994', '1995'
    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000
    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800
datasg ends
table segment
    ; len = 32 (7:12:8:4:1)
    db 21 dup ('                               ',0)
table ends
; ds:00 53
; ds:54 a7
; ds:a8 d1
; ds:e0 7f

stacksg segment stack
    db 32 dup (0)
stacksg ends

codesg segment
start:
    mov ax, stacksg
    mov ss, ax
    mov sp, 32
    mov ax, datasg
    mov ds, ax
    mov ax, 0b800h
    mov es, ax

    mov bx, 224

    mov si, 0
    mov di, 0
    mov cx, 21
    s:
        mov ax, [si]
        mov [bx].[di], ax
        mov ax, 2[si]
        mov [bx].2[di], ax
        add si, 4
        add di, 32
        loop s

    mov si, 84
    mov di, 0
    mov cx, 21
    s1:
        mov ax, [si]
        mov dx, 2[si]
        push si
        
        ; si = bx + di + 7
        mov si, bx
        add si, di
        add si, 7
        call ddtoc
        pop si
        
        add si, 4
        add di, 32
        loop s1

    mov si, 168
    mov di, 0
    mov cx, 21
    s2:
        mov dx, 0
        mov ax, [si]
        push si

        ; si = bx + di + 19
        mov si, bx
        add si, di
        add si, 19
        call ddtoc
        pop si
        add si, 2
        add di, 32
        loop s2

    mov si, 84
    mov bx, 168
    mov di, 0
    mov cx, 21
    s3:
        push cx
        mov ax, [si]
        mov dx, 2[si]
        mov cx, [bx]
        div cx
        pop cx
        mov dx, 0

        push si
        ; si = 224 + di + 27
        mov si, 224
        add si, di
        add si, 27
        call ddtoc
        pop si
        add si, 4
        add bx, 2
        add di, 32
        loop s3

    mov dh, 1
    mov dl, 3
    mov si, 224
    mov cx, 21
    l0:
        inc dh
        push cx
        mov cl, 2
        call show_str
        add si, 32
        pop cx
        loop l0
    
    mov ax, 4c00h
    int 21h


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
    mov byte ptr ds:[si], 20h
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


show_str:
    push dx
    push cx
    push ax
    push si

    ; row position
    mov ah, 0
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
    ; mov bx, si
    ; mov al, bl
    ; mov bl, 2
    ; mul bl
    ; add di, ax

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
    pop ax
    pop cx
    pop dx
    ret

codesg ends

end start