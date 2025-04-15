; VU COAL CH # 4 Q: 3 (Alternate Solution)

[org 0x0100]

    jmp start

    start:
        mov ax, 0xabcd
        mov bx, 1111000011110000b
        mov dx, 0000111100001111b

        and bx, ax
        and dx, ax

        shr bx, 4
        shl dx, 4

        or bx, dx

        mov ax, bx

    end:
        mov ax, 4c00h
        int 21h