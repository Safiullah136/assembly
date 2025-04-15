; VU COAL CH # 4 Q: 7

[org 0x0100]

    jmp start

    start:
        mov bx, 0xabcd
        mov ax, 7
        mov dx, 1

        mov cx, ax
        shl dx, cl
        xor bx, dx

    end:
        mov ax, 0x4c00
        int 21h

