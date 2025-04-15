; by default all segment registers have same value in MS DOS 
; hello world printing 
[org 0x0100]

    jmp start

    message: db 'hello world!'
    length: dw 12

; subroutine to clear the screen
    clrscr:
        push ax
        push cx
        push es
        push di

        mov ax, 0xb800
        mov es, ax
        xor di, di
        mov ax, 0x0720
        mov cx, 2000

        cld 
        rep stosw

        pop di
        pop es
        pop cx
        pop ax
        ret

; subroutine to print a string
; takes the x position, y position, attribute, address of string and
; its length as parameters
    printstr:
        push bp
        mov bp, sp
        push ax
        push cx
        push di
        push si
        push es

        mov ax, 0xb800
        mov es, ax

        sub byte [bp + 10], 1
        sub byte [bp + 12], 1
        mov al, 80                  ; load al with columns per row
        mul byte [bp + 10]           ; multiply with y position
        add ax, [bp + 12]           ; add x position
        shl ax, 1                   
        mov di, ax

        mov ah, [bp + 8]
        mov si, [bp + 6]
        mov cx, [bp + 4]


        cld 
    nextchar:
        lodsb
        stosw
        loop nextchar 

        pop es
        pop si
        pop di
        pop cx
        pop ax
        pop bp
        ret 10

    start:
        call clrscr

        mov ax, 30          ; x pos
        push ax
        mov ax, 20          ; y pos
        push ax
        mov ax, 1           ; attribute
        push ax
        mov ax, message     
        push ax
        push word [length]
        
        call printstr 

        mov ah, 0x1
        int 21h

        mov ax, 0x4c00
        int 21h