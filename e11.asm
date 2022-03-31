assume cs:codesg, ds:datasg

datasg segment
    db "Begginner's All-purpose Symbolic Insutruction Code.", 0
datasg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax
    mov si, 0
    call letterc

    mov ax, 4c00h
    int 21h

letterc:
    s0:
        mov cl, [si]
        mov ch, 0
        jcxz ok
        cmp cl, 97
        jb next
        cmp cl, 122
        ja next
        sub cl, 32
        mov [si], cl
    next:
        inc si
        loop s0
    ok:
        ret

codesg ends

end start