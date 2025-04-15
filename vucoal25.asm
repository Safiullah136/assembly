; VU COAL CH # 6 Q: 2

[org 0x0100]

    jmp start

    character: dw '*'

    clrscr:
        push ax
        push cx
        push di
        push es

        mov ax, 0xb800
        mov es, ax
        xor di, di
        mov ax, 0x0720
        mov cx, 2000

        cld 
        rep stosw

        pop es
        pop di
        pop cx
        pop ax
        ret

    clash:
        push bp
        mov bp, sp
        pusha

        mov ax, 0xb800
        mov es, ax

        mov bx, 12

        ; Calculating the starting position
        mov al, 80
        mul bl
        shl ax, 1

        mov si, ax
        mov di, si
        
        add di, 158

        mov cx, 38

        ; Loading the characters
        mov ah, 0x07
        mov al, [bp + 4]

    printing1:
        mov [es:si], ax
        mov [es:di], ax

        call _delay
        call _delay

        mov word [es:si], 0x0720
        mov word [es:di], 0x0720

        add si, 2
        sub di, 2

        loop printing1

        mov cx, 39

    printing2:
        mov [es:si], ax
        mov [es:di], ax

        call _delay
        call _delay

        mov word  [es:si], 0x0720
        mov word [es:di], 0x0720

        sub si, 2
        add di, 2

        loop printing2

        mov cx, 39
        
        jmp printing1

    _delay:
        push dx

        mov dx, 0xFFFF

    l1:
        dec dx
        jnz l1

        pop dx
        ret

    return:
        popa
        pop bp
        ret 2

    start:
        call clrscr

        push word [character]
        call clash

        mov ax, 0x4c00
        int 21h