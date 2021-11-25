assume cs:code

a segment
db 1, 2, 3, 4, 5, 6, 7, 8
a ends

b segment
db 1, 2, 3, 4, 5, 6, 7, 8
b ends

c segment
db 0, 0, 0, 0, 0, 0, 0, 0
c ends

code segment
start:
    mov ax, a
    mov ds, ax
    mov ax, c
    mov es, ax
    
    mov bx, 0h
    mov cx,8
    s1: 
        mov ax, ds:[bx]
        mov es:[bx], ax
        add bx, 2
        loop s1
    
    mov ax, b
    mov ds, ax
    mov ax, c
    mov es, ax

    mov bx, 0h
    mov cx,8
    s2: 
        mov ax, ds:[bx]
        add es:[bx], ax
        add bx,2
        loop s2

    mov ax,4c00h
    int 21h
code ends

end start



; mov ax,a
; mov es,ax
; mov ax,c
; mov ds,ax

; mov bx,0
; mov cx,8

; s1:mov ax,es:[bx]
; add [bx],ax
; add bx,2
; loop s1

; mov ax,b
; mov es,ax
; mov ds,ax

; mov bx,0
; mov cx,8

; s2:mov ax,es:[bx]
; add [bx],ax
; add bx,2
; loop s2