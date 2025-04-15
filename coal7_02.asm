; number printing algorithm
[org 0x0100]

    jmp start

    clrscr:
        push es
        push ax
        push di

        mov ax, 0xb800
        mov es, ax
        mov di, 0

    nextloc:
        mov word [es:di], 0x0720
        add di, 2
        cmp di, 4000
        jne nextloc

        pop di
        pop ax
        pop es
        ret

; subroutine to print a number at top left of screen
; takes the number to be printed as its parameter

    printnum:
        push bp 
        mov bp, sp
        push ax
        push bx
        push cx
        push dx
        push es
        push di

        mov ax, 0xb800
        mov es, ax
        mov ax, [bp + 4]
        mov bx, 8           ; division base 10
        mov cx, 0

    nextdigit:
        mov dx, 0           ; zero upper half of dividend
        div bx
        add dl, 0x30        ; convert digit into ascii value
        push dx
        inc cx
        cmp ax, 0
        jnz nextdigit

        mov di, 0

    nextpos:
        pop dx
        mov dh, 0x07
        mov [es:di], dx
        add di, 2
        loop nextpos

        pop di
        pop es
        pop dx
        pop cx
        pop bx
        pop ax
        pop bp
        ret 2

    start:
        call clrscr

        mov ax, 4529
        push ax
        call printnum

        mov ah, 0x01
        int 21h

        mov ax, 0x4c00
        int 0x21