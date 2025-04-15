; hello world at desired screen location

[org 0x0100]

    jmp start

    message: db 'hello world!'
    length: dw 12

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

; subroutine to print a string at top left of screen
; takes x position, y position, string attribute, address of string
; and its length as parameters
    printstr:
        push bp
        mov bp, sp
        push ax
        push cx
        push di
        push es
        push si

        mov ax, 0xb800
        mov es, ax
        sub byte [bp + 10], 1
        sub byte [bp + 12], 1
        mov al, 80                  ; load al with columns per row
        mul byte [bp+10]           ; multiply with y position
        add ax, [bp + 12]           ; add x position
        shl ax, 1                   
        mov di, ax
; mov di, 160  second row. NOPE i need 1st row. Do Key Interrupt

        mov si, [bp + 6]
        mov cx, [bp + 4]
        mov ah, [bp + 8]            ; normal attribute fixed in ah. SO do it once

    nextchar:
        mov al, [si]
        mov [es:di], ax 
        add di, 2
        add si, 1
        loop nextchar

        pop si
        pop es
        pop di
        pop cx
        pop ax
        pop bp
        ret 10

    start:
        call clrscr

        mov ax, 69
        push ax                 ; push x-position
        mov ax, 25
        push ax                 ; push y-position
        mov ax, 1
        push ax                 ; blue on black attribute
        mov ax, message 
        push ax
        push word [length]
        call printstr

        ; wait for keypress (OS don't interfere (places prompt and scrolls onw row up) while i am displaying)
        mov ah, 0x1        ; input char is 0x1 in ah 
        int 0x21 

        ; After keypress control comes from OS to program

    end:
        mov ax, 0x4c00
        int 21h

