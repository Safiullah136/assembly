; comparing null terminated strings

[org 0x0100]

    jmp start

    msg1: db 'hello world', 0
    msg2: db 'hello WORLD', 0
    msg3: db 'hello world', 0

; subroutine to calculate the length of a string
; takes the segment and offset of a string as parameters
    strlen:
        push bp
        mov bp, sp
        push cx
        push di
        push es

        les  di, [bp+4]     ; load DI from BP+4 and ES from BP+6
        mov  cx, 0xffff     ; maximum possible length 
    
        xor  al, al         ; value to find 
        repne scasb         ; repeat until scan does not become NE to AL 
                            ; decrement CX each time 

        mov  ax, 0xffff     
        sub  ax, cx         ; find how many times CX was decremented 

        dec  ax             ; exclude null from the length 

        pop es
        pop di
        pop cx
        pop bp
        ret 4

; subroutine to compare two strings
; takes segment and offset pairs of two strings to compare
; returns 1 in ax if they match and 0 other wise

    strcmp:
        push bp
        mov bp, sp
        push cx
        push di
        push ds
        push es
        push si

        lds si, [bp + 8]
        les di, [bp + 4]

        push ds
        push si
        call strlen
        mov cx, ax

        push es
        push di
        call strlen
        cmp cx, ax                  ; compare length of both strings
        jne exitfalse               ; return 0 if they are unequal

        mov ax, 1
        repe cmpsb
        jcxz exitsimple

    exitfalse: 
        mov ax, 0            ; store 0 to mark unequal
    
    exitsimple:
        pop si
        pop es
        pop ds
        pop di
        pop cx
        pop bp
        ret 8

    start:
        push ds
        mov ax, msg1
        push ax
        push ds
        mov ax, msg2
        push ax
        call strcmp

        push ds
        mov ax, msg1
        push ax
        push ds
        mov ax, msg3
        push ax
        call strcmp

        mov ax, 0x4c00 
        int 21h