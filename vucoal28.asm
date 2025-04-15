; VU COAL CH # 7 Q: 2

[org 0x0100]

    jmp start

    _segment: dw 0x3000
    _offset : dw 0x1000

    reverseArray:
        push bp
        mov bp, sp
        push ax
        push cx
        push di
        push ds
        push es
        push si

        mov ax, [bp + 4]
        shr ax, 4
        add ax, [bp + 6]
        mov ds, ax
        add ax, 0x0fa0      ; 0fa0 = 64000 = 32000 words 
        mov es, ax

        xor si, si
        mov di, 0x0fa0
        sub di, 2
        mov cx, 0x07d0      ; 07d0 = 32000 

        l1:
            movsw
            sub di, 2
            add si, 2
            loop l1


        pop si
        pop es
        pop ds
        pop di
        pop cx
        pop ax
        pop bp
        ret 4 


    start:
        push word [_segment]
        push word [_offset]
        call reverseArray

    end:
        mov ax, 0x4c00 
        int 21h