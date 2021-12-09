assume cs:codesg, ds:datasg

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
    db 21 dup ('year summ ne ?? ')
table ends
; ds:0 53
; ds:54 a7
; ds:a8 d1
; ds:e0 22f

codesg segment
start:
    mov ax, datasg
    mov ds, ax

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
        add di, 16
        loop s

    mov si, 84
    mov di, 0
    mov cx, 21
    s1:
        mov ax, [si]
        mov [bx].5[di], ax
        mov ax, 2[si]
        mov [bx].7[di], ax
        add si, 4
        add di, 16
        loop s1

    mov si, 168
    mov di, 0
    mov cx, 21
    s2:
        mov ax, [si]
        mov [bx].10[di], ax
        add si, 2
        add di, 16
        loop s2
    
    mov si, 224
    mov cx, 21
    s3:
        mov ax, 5[si]
        mov dx, 7[si]
        mov bx, 10[si]
        div bx
        mov 13[si], ax
        add si, 16
        loop s3
    mov ax, 4c00h
    int 21h
codesg ends

end start