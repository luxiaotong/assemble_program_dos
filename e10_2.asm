assume cs:codesg

codesg segment
start:
    mov ax, 4240h
    mov dx, 000fh
    mov cx, 0ah
    call divdw

    mov ax, 4c00h
    int 21h

; X/N = int(H/N)*65536 + [rem(H/N)*65536+L]/N

; 除法 div: dx:ax / cx = ax(%dx)
; 乘法 mul: ax * bx = dx:ax

; 输入: ; 低位被除数: ax, 高位被除数: dx 除数: cx
; 输出: 低位结果: ax, 高位结果: dx, 余数 cx
divdw:
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
    
    ret

codesg ends

end start