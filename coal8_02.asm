; hello world printing with a null terminated string
[org 0x0100]

    jmp start

    message: db 'hello world!', 0               ; null terminated string

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

; subroutine to print a string
; takes the x position, y position, attribute, and address of a null
; terminated string as parameters
    printstr:
        push bp
        mov bp, sp
        push ax
        push cx
        push di
        push si
        push es

        push ds                 ; push segment of string
        push word [bp + 4]      ; push offset of string
        call strlen             ; return value is in AX 

        cmp ax, 0
        jz exit
        mov cx, ax              ; load string length in cx
        
        mov ax, 0xb800
        mov es, ax

        sub byte [bp + 8], 1
        sub byte [bp + 10], 1
        mov al, 80                  ; load al with columns per row
        mul byte [bp + 8]           ; multiply with y position
        add ax, [bp + 10]           ; add x position
        shl ax, 1                   
        mov di, ax

        mov ah, [bp + 6]
        mov si, [bp + 4]


        cld 
    nextchar:
        lodsb
        stosw
        loop nextchar 

    exit:
        pop es
        pop si
        pop di
        pop cx
        pop ax
        pop bp
        ret 8

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
        
        call printstr 

        mov ah, 0x1
        int 21h

        mov ax, 0x4c00
        int 21h