; 'welcome to masm!'复制到后面数据区
assume cs:codesg, ds:datasg

datasg segment
    db 'welcome to masm!'
    db 0, 0, 0, 0, 0, 0, 0, 0
datasg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax
    mov si, 0
    ; mov di, 16
    mov cx, 8
    s:
        mov ax, 0[si]
        ; mov [di], ax
        mov 16[si], ax
        add si, 2
        ; add di, 2
        loop s
    mov ax, 4c00h
    int 21h
codesg ends

end start