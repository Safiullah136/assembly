; VU COAL CH # 6 Q: 3

[org 0x0100]

    jmp start

    _segment: dw 0x08AB
    _offset: dw 0xFFFF

    start:
        call clrscr

        push word [_segment]
        push word [_offset]
        call printaddr

        mov ah, 0x1
        int 21h

        mov ax, 0x4c00
        int 21h

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

    print:
        cmp bl, 9
        jg hex
        jle decimal
    
    decimal:
        add bl, 0x30
        jmp l1

    hex:
        add bl, 55
        jmp l1

    l1:
        mov [es:di], bx
        add di, 2

        ret

    printaddr:
        push bp
        mov bp, sp
        pusha

        mov ax, 0xb800
        mov es, ax
        xor di, di

        ; Calculating the Physical Address

        mov ax, [bp + 6]            ; segment address
        mov bx, 0x10
        mul bx

        add ax, [bp + 4]            ; adding the offset
        adc dx, 0

        mov bh, 0x07

    ; Printing Most Signicant Nibble of Physical Address present in dx
    nibble_1:
        mov bl, 00001111b
        and bl, dl
        call print

    
    ; Printing the ax part of PA 

    nibble_2:
        mov bl, 11110000b
        and bl, ah
        shr bl, 4
        call print

    nibble_3:
        mov bl, 00001111b
        and bl, ah
        call print

    nibble_4:
        mov bl, 11110000b
        and bl, al
        shr bl, 4
        call print

    nibble_5:
        mov bl, 00001111b
        and bl, al
        call print

    return:
        popa
        pop bp
        ret