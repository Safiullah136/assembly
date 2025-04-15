; scroll up the screen

[org 0x0100]

    jmp start

; subroutine to scroll up the screen
; take the number of lines to scroll as parameter
    scrollup:
        push bp
        mov bp, sp
        push ax
        push cx
        push di
        push ds
        push es 
        push si

        mov ax, 80
        mul byte [bp + 4]
        push ax
        mov si, ax
        shl si, 1

        mov cx, 2000
        sub cx, ax              ; count of words to move

        mov ax, 0xb800
        mov es, ax
        mov ds, ax
        xor di, di
        cld 
        rep movsw

        mov ax, 0x0720
        pop cx                  ; count of positions to clear
        rep stosw               ; clear the scrolled space

        pop si
        pop es
        pop ds
        pop di
        pop cx
        pop ax
        pop bp
        ret 2


    start:
        mov ax, 5
        push ax
        call scrollup

        mov ax, 0x4c00
        int 21h