; VU COAL CH # 4 Q: 4

[org 0x0100]

    start:
        mov ax, 0x1234
		mov bx, 0xABCD
        mov cx, 0

        ; Calculating the no. of bits in bx

        mov dx, bx

        loop1:
            shr bx, 1
            jnc skip

                inc cx

            skip:
                cmp bx, 0
                jnz loop1

        mov dx, 0000000000000001b

        ; complementing from left to right the least significant bits of ax (one at a time)

        loop2:
            cmp cx, 0
            jz end

            xor ax, dx

            shl dx, 1
            dec cx
            jmp loop2

    end:
        mov ax, 0x4c00
        int 21h