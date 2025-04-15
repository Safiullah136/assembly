; VU COAL CH # 4 Q: 6

[org 0x0100]

    jmp start

    buffer:			db 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32
    startingBit:	db 96

    start:
        mov dx, 1111111100000000b
        mov bx, 8
        mov ax, 0
        mov cx, 0

        mov al, [startingBit]

        div bl

        mov bx, 0

        mov bl, al
        mov si, bx

        cmp ah, 0
        jz state0
        jnz state1

    ; Desired Byte doesn't split into two bytes

    state0:
        mov al, [buffer + si]

        jmp end

    ; Desired Byte splits into two bytes 

    state1:
        mov cl, ah 
        mov bh, [buffer + si]               ; Done to maintain the order of bytes in bx
        mov bl, [buffer + si + 1]
        shl bx, cl

        and dx, bx

        mov ax, 0
        mov al, dh
        jmp end

    end:
        mov ax, 0x4c00
        int 21h