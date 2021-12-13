assume cs:codesg, ds:datasg, ss:stacksg

datasg segment
    db 'welcome to masm!'
    db 02h, 24h, 71h
datasg ends

stacksg segment
    db 0, 0, 0
stacksg ends

codesg segment
start:
    mov ax, datasg
    mov ds, ax
    mov ax, stacksg
    mov ss, ax
    mov sp, 3
    mov ax, 0b800h
    mov es, ax

    mov di, 2142
    ; mov di, 160
    mov bx, 16

    mov cx, 3
    s0: 
        mov si, 0
        push cx
        mov cx, 16
        s1:
            mov al, ds:[si]
            mov byte ptr es:[di], al
            mov ah, ds:[bx]
            mov byte ptr es:[di+1], ah
            inc si
            add di, 2
            loop s1
        add di, 128
        inc bx
        pop cx
        loop s0
    
    mov ax, 4c00h
    int 21h
codesg ends

end start
