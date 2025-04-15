; VU COAL CH # 4 Q: 3

[org 0x0100]

    jmp start

    _bits: dw 0, 0

    start:
        mov cx, 0
        mov ax, 0xABCD
        mov bx, 1000000000000000b
        mov dx, 1000100000000000b
        mov si, 0
        mov di, 0
        mov bp, 0
    
    loop1:
        test bx, ax
        jz save0
        jnz save1

    l1:
        shr bx, 4
        jmp loop1

    l2:
        mov bp, 0

        shl bx, 3
        jmp swap

    l3:
        inc cx
        cmp cx, 4
        jz update                       ; After the nibbles in ah are swapped, the masks in bx and dx are updated
        cmp cx, 8
        jz end

        jmp loop1


    save0:
        mov word [_bits + si], 0
        add si, 2
        inc bp
        cmp bp, 2
        jz l2
        jmp l1
    
    save1:
        mov word [_bits + si], 1
        add si, 2
        inc bp
        cmp bp, 2
        jz l2
        jmp l1

    update:
        mov bx, 0000000010000000b
        mov dx, 0000000010001000b

        jmp loop1

    swap:
        mov si, 0

        mov di, [_bits]
        cmp di, [_bits + 2]
        jz l4                           ; If the bits are same then do nothing

        xor ax, dx

    l4:
        shr dx, 1
        jmp l3

    end:
        mov ax, 0x4c00
        int 0x21 

        