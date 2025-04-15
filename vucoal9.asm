; VU COAL CH # 4 Q: 1 (Alternate Solution)

[org 0x0100]

    start:
        mov ax, 0xABCD
        mov bx, 1010101010101010b
        mov dx, 0101010101010101b

        and bx, ax
        and dx, ax

        shr bx, 1
        shl dx, 1
        
        or bx, dx

        mov ax, bx

    end:
        mov ax, 0x4c00
        int 21h

; GREAT SOLUTION FOR SWAPPING OF BITS