; VU COAL CH # 4 Q: 3 (Alternate Solution # 2)

[org 0x0100]

    jmp start

    start:
        mov ax, 0xabcd
        ror al, 4                            ; Both rotate left or rotate right can be used
        rol ah, 4

    end:
        mov ax, 4c00h
        int 21h